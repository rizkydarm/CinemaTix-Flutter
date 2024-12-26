
import 'package:cinematix/core/_core.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:cinematix/view/page/_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:talker_flutter/talker_flutter.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'Wallet');

final router = GoRouter(
  observers: [TalkerRouteObserver(getit.get<Talker>())],
  initialLocation: '/login',
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
          return PageRouteAnimator(
            routeAnimation: RouteAnimation.topToBottomWithFade,
            curve: Curves.easeOutCirc,
            child: child,
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
    GoRoute(
      path: '/book_time_place/:movieId', 
      builder: (context, state) => BookTimePlacePage(
        movieId: state.pathParameters['movieId'] as String,
      ),
    ),
    GoRoute(
      path: '/talker_screen', 
      builder: (context, state) => TalkerScreen(talker: getit.get<Talker>()),
    ),
    GoRoute(
      path: '/login', 
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register', 
      builder: (context, state) => RegisterPage(),
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