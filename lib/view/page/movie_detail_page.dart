part of '_page.dart';

class MovieDetailPage extends StatelessWidget {

  final String movieId;
  
  const MovieDetailPage({super.key,
    required this.movieId,
  });
  
  @override
  Widget build(BuildContext context) {

    final showBottomAppBarNotifier = ValueNotifier(false);

    context.read<MovieDetailCubit>().fetchMovieDetailById(movieId)
      .whenComplete(() {
        showBottomAppBarNotifier.value = true;
      });
    context.read<MovieCreditsCubit>().fetchMovieCreditsById(movieId);
    
    final scrollNotifier = ValueNotifier(0);
    final scrollController = ScrollController();
    scrollController.addListener(() {
      scrollNotifier.value = scrollController.offset.roundToDouble().toInt();
    });

    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: showBottomAppBarNotifier,
        builder: (context, value, child) {
          return value ? child! : const SizedBox.shrink();
        },
        child: BottomAppBar(
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
              IconButton(
                onPressed: () {
                  final detail = context.read<MovieDetailCubit>().movieDetailTemp;
                  if (detail != null) {
                    Share.share("${detail.movie.title} ${detail.tagline}");
                  }
                },
                icon: const Icon(Icons.share),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          _MovieDetailPageBody(scrollController: scrollController,),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,59+8,0,0),
            child: ValueListenableBuilder(
              valueListenable: scrollNotifier,
              builder: (context, offset, child) {
                return AnimatedOpacity(
                  opacity: (offset - 200).clamp(0.0, 1.0).toDouble(),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  child: Transform.scale(
                    scale: (offset - 200).clamp(0.0, 1.0).toDouble(),
                    child: child
                  ),
                );
              },
              child: IconButton.filled(
                color: Colors.white,
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetailPageBody extends StatelessWidget {
  const _MovieDetailPageBody({
    required this.scrollController
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, BlocState>(
      buildWhen: (previous, current) => current is! LoadingState,
      builder: (context, state) {
        if (state is LoadingState) {
          return const _LoadingMovieDetailPage();
        }
        else if (state is ErrorState) {
          return Center(child: Text(state.message));
        }
        else if (state is SuccessState<MovieDetailEntity>) {
          return CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 200.0,
                toolbarHeight: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      FastCachedImage(
                        url: TMDBApi.getImageUrl(state.data.backdropPath),
                        fit: BoxFit.fill,
                        fadeInDuration: const Duration(milliseconds: 100),
                        loadingBuilder: (context, progress) => Shimmer(
                          child: const ColoredBox(
                            color: Colors.grey,
                          ),
                        ),
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
                backgroundColor: Colors.black.withOpacity(0.6),
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
                                loadingBuilder: (context, progress) => Shimmer(
                                  child:  const ColoredBox(
                                    color: Colors.grey,
                                  ),
                                ),
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
                                          loadingBuilder: (context, progress) => Shimmer(
                                            child: const SizedBox(
                                              width: 100,
                                              child: ColoredBox(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
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
    );
  }
}

class _LoadingMovieDetailPage extends StatelessWidget {
  const _LoadingMovieDetailPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Shimmer(
          child: const SizedBox(
            height: 200+56,
            child: ColoredBox(
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Shimmer(
                      child: const SizedBox(
                        height: 30,
                        child: ColoredBox(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Shimmer(
                      child: const SizedBox(
                        height: 30,
                        width: 160,
                        child: ColoredBox(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Shimmer(
                      child: const SizedBox(
                        height: 30,
                        width: 160,
                        child: ColoredBox(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32,),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Shimmer(
                  child: const SizedBox(
                    height: 240,
                    width: 160,
                    child: ColoredBox(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}