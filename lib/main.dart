import 'package:cinematix/core/_core.dart';
import 'package:cinematix/view/page/_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
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
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/list',
      builder: (context, state) => const MovieListPage(),
    ),
    GoRoute(
      path: '/movie_detail/:movieId',
      builder: (context, state) => MovieDetailPage(
        movieTitle: 'Movie Title',
        movieId: state.pathParameters['movieId'] as String,
      ),
    ),
  ],
);