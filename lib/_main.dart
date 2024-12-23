import 'dart:io';

import 'package:cinematix/core/_core.dart';
import 'package:cinematix/data/_data.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cinematix/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talker/talker.dart';
// import 'package:provider/provider.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator_apple/geolocator_apple.dart';


void runMain() {

  WidgetsFlutterBinding.ensureInitialized();

  getTemporaryDirectory().then((dir) {
    FastCachedImageConfig.init(subDir: dir.path, clearCacheAfter: const Duration(days: 15));
  });

  void registerPlatformInstance() {
    if (Platform.isAndroid) {
      GeolocatorAndroid.registerWith();
    } else if (Platform.isIOS) {
      GeolocatorApple.registerWith();
    }
  }
  registerPlatformInstance();

  getit.registerSingleton<Talker>(TalkerHelper().instance);

  getit.registerFactoryParam<DioHelper, String, void>((baseUrl, _) => DioHelper(baseUrl));  
  
  getit.registerSingleton<MovieRemoteDataSource>(MovieRemoteDataSource());
  getit.registerLazySingleton<CityRemoteDataSource>(() => CityRemoteDataSource());
  
  getit.registerSingleton<MovieRepository>(MovieRepository());
  getit.registerLazySingleton<CityRepository>(() => CityRepository());
  
  getit.registerSingleton<MovieUseCase>(MovieUseCase());
  getit.registerLazySingleton<CityUseCase>(() => CityUseCase());
  
  Bloc.observer = TalkerBlocObserver(talker: getit.get<Talker>(),
    settings: const TalkerBlocLoggerSettings(
      enabled: true,
      printChanges: true,
      printClosings: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
    ),
  );

  final providers = MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => PlayingNowMovieCubit()..fetchMovies(max: 5),),
      BlocProvider(
        create: (context) => UpComingMovieCubit()..fetchMovies(max: 5),),
      BlocProvider(
        create: (context) => SearchedMovieCubit()),
      BlocProvider(
        create: (context) => MovieDetailCubit()),
      BlocProvider(
        create: (context) => MovieCreditsCubit()),
      BlocProvider(
        create: (context) => FavoriteMovieCubit()),
      BlocProvider(
        create: (context) => BookTimePlaceCubit()),
      BlocProvider(
        create: (context) => CityCubit())
    ],
    child: const App(),
  );

  runApp(providers);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CinemaTix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: MyColors.material),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold
            )
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey
          )
        ),
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}