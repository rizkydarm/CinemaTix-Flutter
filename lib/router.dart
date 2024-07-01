
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:cinematix/view/page/_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/list/:category',
      builder: (context, state) {
        final category = state.pathParameters['category'] as String;
        if (category == 'playing_now') {
          return const MovieListPage<PlayingNowMovieCubit>();
        } else if (category == 'upcoming') {
          return const MovieListPage<UpComingMovieCubit>();
        } else {
          return const ErrorPage();
        }
      },
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

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(),
      body: const Center(
        child: Text('Error Page'),
      ),
    );
  }
}