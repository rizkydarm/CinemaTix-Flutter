part of '_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final pageIndexNotifier = ValueNotifier(0);
    final pageViewController = PageController();

    return BlocProvider(
      create: (context) => MovieCubit(
        MovieUseCase(
          MovieRepository(
            MovieRemoteDataSource(
              DioHelper(TMDBApi.baseUrl)
            )
          )
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: pageIndexNotifier,
          builder: (context, index, child) {
            return NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (value) {
                pageIndexNotifier.value = value;
                pageViewController.animateToPage(value, 
                  duration: const Duration(milliseconds: 120), 
                  curve: Curves.easeOut
                );
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined), 
                  selectedIcon: Icon(Icons.home),
                  label: 'Home'
                ),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search'
                ),
              ],
            );
          }
        ),
        body: PageView(
          controller: pageViewController,
          children: [
            const InfiniteMovieListView(),
            ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const Divider(height: 0,),
              itemBuilder: (context, index) => ListTile(
                title: Text('Item $index'),
              ),
            )
          ],
        )
      ),
    );
  }
}

class InfiniteMovieListView extends StatefulWidget {
  const InfiniteMovieListView({super.key});

  @override
  State<InfiniteMovieListView> createState() => _InfiniteMovieListViewState();
}

class _InfiniteMovieListViewState extends State<InfiniteMovieListView> {

  final PagingController<int, MovieEntity> _pagingController = PagingController(firstPageKey: 1);
  final int _maxPage = 3;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<MovieCubit>().fetchPlayingNowMovies(page: pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieCubit, BlocState>(
      listener: (context, state) {
        if (state is SuccessState<List<MovieEntity>>) {
          final isLastPage = context.read<MovieCubit>().currentPage >= _maxPage;
          if (isLastPage) {
            _pagingController.appendLastPage(state.data);
          } else {
            final nextPageKey = context.read<MovieCubit>().currentPage + 1;
            _pagingController.appendPage(state.data, nextPageKey);
          }
        } else if (state is ErrorState) {
          _pagingController.error = state.message;
        }
      },
      child: RefreshIndicator(
        onRefresh: () => context.read<MovieCubit>().fetchPlayingNowMovies(page: 1),
        child: PagedListView<int, MovieEntity>.separated(
          separatorBuilder: (context, index) => const Divider(height: 0,),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
            itemBuilder: (context, item, index) => ListTile(
              title: Text(item.title),
              subtitle: Text(item.genres.join(', ')),
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