part of '_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PlayingNowMovieCubit(MovieUseCase())..fetchMovies(max: 5)),
        BlocProvider(create: (context) => UpComingMovieCubit(MovieUseCase())..fetchMovies(max: 5)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Text('Playing Now Movies'),
            SizedBox(height: 16,),
            HorizontalMovieList<PlayingNowMovieCubit>(),
            SizedBox(height: 16,),
            Text('Upcoming Movies'),
            SizedBox(height: 16,),
            HorizontalMovieList<UpComingMovieCubit>(),
          ],
        ),
      ),
    );
  }
}

class HorizontalMovieList<T extends Cubit<BlocState>> extends StatelessWidget {
  const HorizontalMovieList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BlocBuilder<T, BlocState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is ErrorState) {
            return Center(child: Text(state.message));
          }
          else if (state is SuccessState<List<MovieEntity>>) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.data.length,
              separatorBuilder: (context, index) => const SizedBox(width: 4,),
              itemBuilder: (context, index) {
                final movie = state.data[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(TMDBApi.getImageUrl(movie.posterPath),
                            height: 200,
                          ),
                          Text(movie.title,
                            textAlign: TextAlign.center, 
                            overflow: TextOverflow.ellipsis, 
                            maxLines: 2,
                          ),
                          Text(movie.genres.join(', '), overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        }
      ),
    );
  }
}
