
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:cinematix/view/page/_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return DashboardNavPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const MaterialPage(
                child: HomePage(),
              ),
              // routes: [
                
              // ],
            ),
          ]
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/wallet',
              pageBuilder: (context, state) => const MaterialPage(
                child: WalletPage(),
              ),
            ),
          ]
        )
      ]
    ),
    GoRoute(
      path: '/search',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SearchPage(),
        transitionsBuilder: ((context, animation, secondaryAnimation, child) {
          return PageTransition(
            ctx: context,
            child: child,
            curve: Curves.easeOutCirc,
            type: PageTransitionType.size,
            alignment: Alignment.topCenter,
          ).buildTransitions(context, animation, secondaryAnimation,child);
        }),
      ),
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
      body: Center(
        child: Text('Page is not found'.toUpperCase(),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}