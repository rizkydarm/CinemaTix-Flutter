part of '_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<PlayingNowMovieCubit>().fetchMovies(max: 5);
    context.read<UpComingMovieCubit>().fetchMovies(max: 5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              context.push('/list/playing_now');
            },
            title: const Text('Playing Now Movies'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(height: 16,),
          const HorizontalMovieList<PlayingNowMovieCubit>(),
          const SizedBox(height: 16,),
          ListTile(
            onTap: () {
                context.push('/list/upcoming');
              },
            title: const Text('Upcoming Movies'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(height: 16,),
          const HorizontalMovieList<UpComingMovieCubit>(),
        ],
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
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: state.data.length,
              separatorBuilder: (context, index) => const SizedBox(width: 4,),
              itemBuilder: (context, index) {
                final movie = state.data[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      context.push('/movie_detail/${movie.id}');
                    },
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
