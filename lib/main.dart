import 'package:cinematix/core/_core.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cinematix/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  final providers = MultiBlocProvider(
    providers: [
      Provider(
        create: (context) => MovieUseCase(),),
      BlocProvider(
        create: (context) => SearchedMovieCubit(context.read<MovieUseCase>()),),
      BlocProvider(
        create: (context) => PlayingNowMovieCubit(context.read<MovieUseCase>()),),
      BlocProvider(
        create: (context) => UpComingMovieCubit(context.read<MovieUseCase>()),),
      BlocProvider(
        create: (context) => MovieDetailCubit(context.read<MovieUseCase>())),
      BlocProvider(
        create: (context) => MovieCreditsCubit(context.read<MovieUseCase>())),
      BlocProvider(
        create: (context) => FavoriteMovieCubit(),
      ) 
    ],
    child: const MyApp(),
  );

  runApp(providers);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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