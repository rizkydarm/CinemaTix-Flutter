import 'package:cinematix/core/_core.dart';
// import 'package:cinematix/domain/_domain.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:cinematix/view/page/_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:talker_flutter/talker_flutter.dart';

GoRouter createRouter(String initialLocation) => GoRouter(
  observers: [TalkerRouteObserver(getit.get<Talker>())],
  initialLocation: initialLocation,
  // refreshListenable: StreamToListenable([context.read<AuthCubit>().stream]),
  // redirect: (context, state) {
  //   final authCubit = context.read<AuthCubit>();
  //   final authState = authCubit.state;
  //   if (authState is SuccessState<UserEntity>) {
  //     return '/home';
  //   } else if (authState is ErrorState) {
  //     return '/login';
  //   }
  //   return null;
  // },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return DashboardNavPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const MaterialPage(
                child: HomePage(),
              ),
            ),
          ]
        ),
        StatefulShellBranch(
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
          ).buildTransitions(context, animation, secondaryAnimation, child);
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
      path: '/seat_ticket', 
      builder: (context, state) => const SeatTicketPage()
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
    GoRoute(
      path: '/checkout', 
      builder: (context, state) => const CheckoutPage(),
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