part of '_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayingNowMovieCubit(MovieUseCase()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const InfiniteMovieListView(),
      ),
    );
  }
}