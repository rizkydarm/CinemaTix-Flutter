import 'package:cinematix/core/_core.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cinematix/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void runMain() {

  WidgetsFlutterBinding.ensureInitialized();

  getTemporaryDirectory().then((dir) {
    FastCachedImageConfig.init(subDir: dir.path, clearCacheAfter: const Duration(days: 15));
  });
  
  final providers = MultiBlocProvider(
    providers: [
      Provider(
        create: (context) => MovieUseCase(),),
      BlocProvider(
        create: (context) => SearchedMovieCubit(context.read<MovieUseCase>()),),
      BlocProvider(
        create: (context) => PlayingNowMovieCubit(context.read<MovieUseCase>())..fetchMovies(max: 5),),
      BlocProvider(
        create: (context) => UpComingMovieCubit(context.read<MovieUseCase>())..fetchMovies(max: 5),),
      BlocProvider(
        create: (context) => MovieDetailCubit(context.read<MovieUseCase>())),
      BlocProvider(
        create: (context) => MovieCreditsCubit(context.read<MovieUseCase>())),
      BlocProvider(
        create: (context) => FavoriteMovieCubit(),
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CinemaTix',
      theme: ThemeData(
        primarySwatch: MyColors.material,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}