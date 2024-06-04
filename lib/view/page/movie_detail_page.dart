part of '_page.dart';

class MovieDetailPage extends StatelessWidget {

  final String movieId;
  final String movieTitle;
  
  const MovieDetailPage({super.key,
    required this.movieTitle,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailCubit(MovieUseCase())
        ..fetchMovieDetailById(movieId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(movieTitle),
        ),
        body: BlocBuilder<MovieDetailCubit, BlocState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is ErrorState) {
              return Center(child: Text(state.message));
            }
            else if (state is SuccessState<MovieDetailEntity>) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Image.network(TMDBApi.getImageUrl(state.data.backdropPath),
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Image.network(TMDBApi.getImageUrl(state.data.movie.posterPath),
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(state.data.movie.title),
                  const SizedBox(height: 16),
                  Text(state.data.movie.genres.join(', ')),
                  const SizedBox(height: 16),
                  Text(state.data.movie.overview),
                  const SizedBox(height: 16),
                  Text(state.data.movie.isLiked.toString()),
                  const SizedBox(height: 16),
                  Text(state.data.voteAverage.toStringAsFixed(1)),
                  const SizedBox(height: 16),
                  Text(state.data.releaseDate),
                ],
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          }
        ),
      ),
    );
  }
}