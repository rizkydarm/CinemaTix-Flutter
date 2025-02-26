part of '_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    final queryNotifier = ValueNotifier<String>('');

    return ValueListenableProvider.value(
      value: queryNotifier,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          title: SearchMovieTextField(
            onChanged: (query) {
              EasyDebounce.debounce('search-movie', const Duration(milliseconds: 320), () {
                queryNotifier.value = query;
              });
            }
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: queryNotifier,
          builder: (context, value, child) {
            return ResultSearchedMovieListView(
              query: value,
            );
          }
        ),
      ),
    );
  }
}

class SearchMovieTextField extends StatelessWidget {

  final void Function(String) onChanged;

  const SearchMovieTextField({
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      autoFocus: true,
      elevation: WidgetStateProperty.all(0),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
      backgroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      constraints: const BoxConstraints.expand(
        height: 40
      ),
      textStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.black)),
      onChanged: onChanged,
    );
  }
}

class ResultSearchedMovieListView extends StatefulWidget {

  final String query;

  const ResultSearchedMovieListView({
    required this.query,
    super.key});

  @override
  State<ResultSearchedMovieListView> createState() => _ResultSearchedMovieListViewState();
}

class _ResultSearchedMovieListViewState extends State<ResultSearchedMovieListView> {

  final PagingController<int, SearchedMovieEntity> _pagingController = PagingController(firstPageKey: 1);
  final int _maxPage = 3;

  String query = '';

  @override
  void initState() {
    super.initState();
    query = widget.query;
    _pagingController.addPageRequestListener((pageKey) {
      EasyThrottle.throttle('search-page-scroll-throttle', const Duration(milliseconds: 200), () {
        context.read<SearchedMovieCubit>().fetchMovies(query, page: pageKey);
      });   
    });
  }

  @override
  void didUpdateWidget(covariant ResultSearchedMovieListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    query = widget.query;
    _pagingController.notifyPageRequestListeners(1);
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchedMovieCubit, BlocState>(
      listenWhen: (previous, current) => current is! LoadingState,
      listener: (context, state) {
        if (state is SuccessState<List<SearchedMovieEntity>>) {
          final cubit = context.read<SearchedMovieCubit>();
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
      child: PagedListView<int, SearchedMovieEntity>.separated(
        separatorBuilder: (context, index) => const Divider(height: 0,),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<SearchedMovieEntity>(
          itemBuilder: (context, item, index) => ListTile(
            onTap: () {
              context.push('/movie_detail/${item.id}');
            },
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
      )
    );
  }
}