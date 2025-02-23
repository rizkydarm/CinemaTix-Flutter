part of '_page.dart';

class MovieListPage<T extends MovieCubit> extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('List Page'),
      ),
      body: InfiniteMovieListView<T>(),
    );
  }
}

class InfiniteMovieListView<T extends MovieCubit> extends StatefulWidget {
  const InfiniteMovieListView({super.key});

  @override
  State<InfiniteMovieListView<T>> createState() => _InfiniteMovieListViewState<T>();
}

class _InfiniteMovieListViewState<T extends MovieCubit> extends State<InfiniteMovieListView<T>> {

  final PagingController<int, MovieEntity> _pagingController = PagingController(firstPageKey: 1);
  final int _maxPage = 3;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      EasyThrottle.throttle('list-page-scroll-throttle', const Duration(milliseconds: 320), () {
        context.read<T>().fetchMovies(page: pageKey);
      });   
    });
    
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<T, BlocState>(
      listenWhen: (previous, current) => current is! LoadingState,
      listener: (context, state) {
        if (state is SuccessState<List<MovieEntity>>) {
          final cubit = context.read<T>();
          final isLastPage = cubit.currentPage >= _maxPage;
          if (isLastPage) {
            _pagingController.appendLastPage(state.data);
          } else {
            final nextPageKey = cubit.currentPage + 1;
            _pagingController.appendPage(state.data, nextPageKey);
          }
        } else if (state is ErrorState) {
          _pagingController.error = state.message;
        }
      },
      child: RefreshIndicator(
        onRefresh: () => context.read<T>().fetchMovies(page: 1),
        child: PagedListView<int, MovieEntity>.separated(
          separatorBuilder: (context, index) => const SizedBox.shrink(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
            itemBuilder: (context, item, index) => ListTile(
              onTap: () {
                context.push('/movie_detail/${item.id}');
              },
              title: Text(item.title ?? '-',
                style: Theme.of(context).textTheme.titleLarge
              ),
              subtitle: Text(item.genres!.join(', ')),
              trailing: FavoriteMovieButton(
                movieId: item.id,
                initalColor: Theme.of(context).disabledColor
              )
            ),
            firstPageProgressIndicatorBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            newPageProgressIndicatorBuilder: (context) => const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Text(_pagingController.error ?? 'Something went wrong'),
            ),
            newPageErrorIndicatorBuilder: (context) => Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: TextButton(
                  onPressed: () => _pagingController.retryLastFailedRequest(),
                  child: const Text('Retry'),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}