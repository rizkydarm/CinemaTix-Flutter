part of '_page.dart';

class MovieDetailPage extends StatelessWidget {

  final String movieId;
  
  const MovieDetailPage({super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {

    context.read<MovieDetailCubit>().fetchMovieDetailById(movieId);
    context.read<MovieCreditsCubit>().fetchMovieCreditsById(movieId);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () {},
                child: const Text('Buy Ticket'),
              ),
            ),
            FavoriteMovieButton(movieId: movieId,
              initalColor: Theme.of(context).disabledColor,
            ),
          ],
        ),
      ),
      body: BlocBuilder<MovieDetailCubit, BlocState>(
        buildWhen: (previous, current) => current is! LoadingState,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is ErrorState) {
            return Center(child: Text(state.message));
          }
          else if (state is SuccessState<MovieDetailEntity>) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        FastCachedImage(
                          url: TMDBApi.getImageUrl(state.data.backdropPath),
                          fit: BoxFit.fill,
                          fadeInDuration: const Duration(milliseconds: 100)
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.data.movie.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(state.data.voteAverage.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(state.data.movie.genres.join(', '),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(state.data.releaseDate),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 240,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                child: FastCachedImage(
                                  url: TMDBApi.getImageUrl(state.data.movie.posterPath),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(state.data.movie.overview),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<MovieCreditsCubit, BlocState>(
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
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('Cast',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.separated(
                                padding: const EdgeInsets.only(left: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: casts.length > 5 ? 5 : casts.length,
                                separatorBuilder: (context, index) => const SizedBox(width: 8,),
                                itemBuilder: (context, index) => SizedBox(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (casts[index].profilePath != null)
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                          child: FastCachedImage(
                                            url: TMDBApi.getImageUrl(casts[index].profilePath!),
                                            width: 100,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      Flexible(
                                        child: Center(
                                          child: Text(casts[index].name, 
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis, maxLines: 2
                                          ),
                                        )
                                      ),
                                    ],
                                  )
                                )
                              )
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('Crew',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.separated(
                                padding: const EdgeInsets.only(left: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: crews.length > 5 ? 5 : crews.length,
                                separatorBuilder: (context, index) => const SizedBox(width: 8,),
                                itemBuilder: (context, index) => SizedBox(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      if (crews[index].profilePath != null) 
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                          child: FastCachedImage(
                                            url: TMDBApi.getImageUrl(crews[index].profilePath!),
                                            width: 100,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      Flexible(
                                        child: Center(
                                          child: Text(crews[index].name, 
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis, maxLines: 2
                                          ),
                                        )
                                      ),
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
                  ),
                )
              ]
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        }
      ),
    );
  }
}