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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieDetailCubit(MovieUseCase())
        ..fetchMovieDetailById(movieId),),
        BlocProvider(create: (context) => MovieCreditsCubit(MovieUseCase())
        ..fetchMovieCreditsById(movieId))
      ],
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
                  StatefulValueBuilder<bool>(
                    initialValue: false,
                    builder: (context, value, setState) {
                      return IconButton(
                        onPressed: () => setState(!(value ?? false)),
                        color: (value ?? false) ? Colors.red : null,
                        icon: const Icon(Icons.favorite),
                      );
                    }
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

                  BlocBuilder<MovieCreditsCubit, BlocState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if (state is ErrorState) {
                        return Center(child: Text(state.message));
                      } else if (state is SuccessState<(List<MovieCrewEntity>, List<MovieCastEntity>)>) {
                        final (crews, casts) = state.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 16),
                            const Text('Cast'),
                            SizedBox(
                              height: 140,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: casts.length,
                                separatorBuilder: (context, index) => const SizedBox(width: 4,),
                                itemBuilder: (context, index) => SizedBox(
                                  width: 140,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (casts[index].profilePath != null) 
                                        Image.network(TMDBApi.getImageUrl(casts[index].profilePath!),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.contain,
                                        )
                                      else 
                                        const SizedBox(height: 100, width: 100,),
                                      Text(casts[index].name, overflow: TextOverflow.ellipsis, maxLines: 1),
                                      Text(casts[index].popularity.toString()),
                                    ],
                                  )
                                )
                              )
                            ),
                            const SizedBox(height: 16),
                            const Text('Crew'),
                            SizedBox(
                              height: 140,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: crews.length,
                                separatorBuilder: (context, index) => const SizedBox(width: 4,),
                                itemBuilder: (context, index) => SizedBox(
                                  width: 140,
                                  child: Column(
                                    children: [
                                      if (crews[index].profilePath != null) 
                                        Image.network(TMDBApi.getImageUrl(crews[index].profilePath!),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.contain,
                                        )
                                      else 
                                        const SizedBox(height: 100, width: 100,),
                                      Text(crews[index].name, overflow: TextOverflow.ellipsis, maxLines: 1),
                                      Text(crews[index].popularity.toString()),
                                    ],
                                  )
                                )
                              )
                            )
                          ],  
                        );
                      } else {
                        return const Center(child: Text('Something went wrong'));
                      }
                    }
                  )
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