part of '_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<FavoriteMovieCubit>().init();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        title: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(
                width: 72,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onDoubleTap: () {
                      context.push('/talker_screen');
                    },
                    child: Image.asset('assets/white_icon.png',
                      width: 48,
                      height: 48,
                    )
                  ),
                ),
              ),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.push('/search');
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black45,
                    padding: const EdgeInsets.only(left: 8)
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 8,),
                      Text('Search'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16,),
          ListTile(
            onTap: () {
              context.push('/list/playing_now');
            },
            title: const Text('Playing Now Movies'),
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AdaptiveTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const HorizontalMovieList<PlayingNowMovieCubit>(),
          const SizedBox(height: 16,),
          ListTile(
            onTap: () {
                context.push('/list/upcoming');
              },
            title: const Text('Upcoming Movies'),
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AdaptiveTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
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
    
    const cardHeight = 400.0;

    return SizedBox(
      height: cardHeight,
      child: BlocBuilder<T, BlocState>(
        buildWhen: (previous, current) => current is! LoadingState,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is ErrorState) {
            return Center(child: Text(state.message));
          }
          else if (state is SuccessState<List<MovieEntity>>) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: state.data.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16,),
              itemBuilder: (context, index) {
                final movie = state.data[index];
                return MovieCard(
                  key: ValueKey(movie.id),
                  movie: movie, height: cardHeight
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

class MovieCard extends StatefulWidget {
  const MovieCard({
    super.key,
    required this.movie,
    required this.height,
  });

  final MovieEntity movie;
  final double height;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    
    const widthCard = 280.0;    

    final movie = widget.movie;
    
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 120),    
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.98),
        onTapUp: (_) => setState(() => _scale = 1.0),
        onTapCancel: () => setState(() => _scale = 1.0),
        onTap: () {
          context.push('/movie_detail/${movie.id}');
        },
        child: SizedBox(
          width: widthCard,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FastCachedImage(
                  url: TMDBApi.getImageUrl(movie.posterPath!),
                  loadingBuilder: (context, progress) {
                    return Shimmer(
                      duration: const Duration(seconds: 1),
                      child: ColoredBox(
                        color: Colors.grey,
                        child: SizedBox(
                          width: widthCard,
                          height: widget.height,
                        ),
                      )
                    );
                  },
                  gaplessPlayback: true,
                  isAntiAlias: true,
                  fadeInDuration: const Duration(milliseconds: 120),
                  fit: BoxFit.cover,
                  cacheHeight: widget.height.toInt(),
                  cacheWidth: widthCard.toInt(),
                  height: widget.height,
                  width: widthCard,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: FavoriteMovieButton(
                      movieId: movie.id, 
                      size: 30,
                      initalColor: Theme.of(context).cardColor
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 240,
                  ),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(movie.title ?? '-',
                            textAlign: TextAlign.center, 
                            overflow: TextOverflow.ellipsis, 
                            maxLines: 2,
                            style: const TextStyle(
                              height: 0,
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '${movie.rating!.toStringAsFixed(1)} • ${movie.genres!.join(', ')}',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center, 
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
