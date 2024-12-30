import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
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

  getit.registerSingleton<Talker>(TalkerHelper.instance);
  
  getit.registerSingletonAsync<SQLHelper>(() => SQLHelper().init());

  getit.registerFactoryParam<DioHelper, String, void>((baseUrl, _) => DioHelper(baseUrl));  
  
  getit.registerSingleton<AuthLocalDataSource>(AuthLocalDataSource());
  getit.registerSingleton<AuthRepository>(AuthRepository());
  getit.registerSingleton<AuthUseCase>(AuthUseCase());

  getit.registerSingleton<MovieRemoteDataSource>(MovieRemoteDataSource());
  getit.registerSingleton<MovieRepository>(MovieRepository());
  getit.registerSingleton<MovieUseCase>(MovieUseCase());
  
  getit.registerLazySingleton<CityRemoteDataSource>(() => CityRemoteDataSource());
  
  getit.registerLazySingleton<CityRepository>(() => CityRepository());
  
  getit.registerLazySingleton<CityUseCase>(() => CityUseCase());

  getit.registerSingleton<FavoriteMovieLocalDataSource>(FavoriteMovieLocalDataSource());
  getit.registerLazySingleton<FavoriteMovieRepository>(() => FavoriteMovieRepository());
  getit.registerLazySingleton<FavoriteMovieUseCase>(() => FavoriteMovieUseCase());
  
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
        create: (context) => BookTimePlaceCubit()),
      BlocProvider(
        create: (context) => CityCubit()),
      BlocProvider(
        create: (context) => AuthCubit()),
      BlocProvider(
        create: (context) => FavoriteMovieCubit(context)..init(),
      )

    ],
    child: const App(),
  );

  runApp(providers);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
        ),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) =>  MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'CinemaTix',
        theme: theme,
        darkTheme: darkTheme,
        
        routerConfig: router,
      )
    );
  }
}