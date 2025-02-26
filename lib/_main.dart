
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
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> runMain() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getTemporaryDirectory().then((dir) {
    FastCachedImageConfig.init(subDir: dir.path, clearCacheAfter: const Duration(days: 15));
  });

  getit.registerSingleton<Talker>(TalkerHelper.instance);
  
  final sqlHelper = await SQLHelper().init();
  getit.registerSingleton<SQLHelper>(sqlHelper);
  
  final sharedPrefHelper = await SharedPrefHelper().init();
  getit.registerSingleton<SharedPrefHelper>(sharedPrefHelper);

  getit.registerFactoryParam<DioHelper, String, void>((baseUrl, _) => DioHelper(baseUrl));  

  getit.registerSingleton<FirebaseAuthDataSource>(FirebaseAuthDataSource());

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

  getit.registerSingleton<TransactionDataSource>(TransactionDataSource());
  getit.registerLazySingleton<TransactionRepository>(() => TransactionRepository());
  getit.registerLazySingleton<TransactionUseCase>(() => TransactionUseCase());
  
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

  PushNotification.initialize();

  final authCubit = AuthCubit();
  await authCubit.getUser();

  final providers = MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => PlayingNowMovieCubit()..fetchMovies(max: 5),),
      BlocProvider(
        create: (context) => UpComingMovieCubit()..fetchMovies(max: 5),),
      BlocProvider(
        create: (context) => SearchedMovieCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => MovieDetailCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => MovieCreditsCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => BookTimePlaceCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => CityCubit(),
        lazy: true,  
      ),
      BlocProvider.value(
        value: authCubit
      ),
      BlocProvider(
        create: (context) => FavoriteMovieCubit(context),
      ),
      BlocProvider(
        create: (context) => CheckoutCubit(),
      ),
      BlocProvider(
        create: (context) => WalletCubit(context),
      ),
    ],
    child: const App(),
  );

  runApp(providers);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    final isLoggedIn = context.read<AuthCubit>().user != null;
    final router = createRouter(isLoggedIn ? '/home' : '/login');

    var themeData = ThemeData(
      useMaterial3: true,      
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: Colors.grey,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return 
    AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        primaryTextTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      dark: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey.shade300,
          ),
        ),  
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.white,
        ),
      ),
      initial: AdaptiveThemeMode.dark,
      debugShowFloatingThemeButton: true,
      builder: (theme, darkTheme) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'CinemaTix',
          theme: theme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          routerConfig: router,
        );
      }
    );
  }
}