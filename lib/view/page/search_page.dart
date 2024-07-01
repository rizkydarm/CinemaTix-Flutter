part of '_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<PlayingNowMovieCubit>().fetchMovies(max: 5);
    context.read<UpComingMovieCubit>().fetchMovies(max: 5);

    return Provider<ValueNotifier>.value(
      value: ValueNotifier<String?>(null),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const SearchMovieTextField(),
        ),
        body: const ResultSearchedMovieListView(),
      ),
    );
  }
}

class SearchMovieTextField extends StatelessWidget {
  const SearchMovieTextField({
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
      onChanged: (value) => context.read<ValueNotifier>().value = value,
    );
  }
}

class ResultSearchedMovieListView extends StatefulWidget {

  const ResultSearchedMovieListView({
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
      context.read<ValueNotifier<String?>>().addListener(() {
        query = context.read<ValueNotifier<String?>>().value ?? '';
      });
    _pagingController.addPageRequestListener((pageKey) {
      if (query.isNotEmpty) {
        context.read<SerachedMovieBloc>().fetchMovies(query, page: pageKey);
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SerachedMovieBloc, BlocState>(
      listenWhen: (previous, current) => current is! LoadingState,
      listener: (context, state) {
        if (state is SuccessState<List<SearchedMovieEntity>>) {
          final cubit = context.read<SerachedMovieBloc>();
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
      child: ValueListenableBuilder<String?>(
        valueListenable: context.read<ValueNotifier<String?>>(),
        builder: (context, value, child) {
          return PagedListView<int, SearchedMovieEntity>.separated(
            separatorBuilder: (context, index) => const Divider(height: 0,),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<SearchedMovieEntity>(
              itemBuilder: (context, item, index) => ListTile(
                onTap: () {
                  context.push('/movie_detail/${item.id}');
                },
                title: Text(item.title),
                subtitle: Text(item.genres.join(', ')),
                trailing: StatefulValueBuilder<bool>(
                  initialValue: false,
                  builder: (context, value, setState) {
                    return IconButton(
                      onPressed: () => setState(!(value ?? false)),
                      color: (value ?? false) ? Colors.red : null,
                      icon: const Icon(Icons.favorite),
                    );
                  }
                ),
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
          );
        }
      )
    );
  }
}