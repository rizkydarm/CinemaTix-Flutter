part of '_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<PlayingNowMovieCubit>().fetchMovies(max: 5);
    context.read<UpComingMovieCubit>().fetchMovies(max: 5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: SearchBar(
          autoFocus: true,
          elevation: WidgetStateProperty.all(0),
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          constraints: const BoxConstraints.expand(
            height: 40
          )
        ),
      ),
      body: Center(
        child: Text('Search Page'),
      )
    );
  }
}