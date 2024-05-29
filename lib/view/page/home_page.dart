part of '_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);
    final pageViewController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    
    return BlocProvider(
      create: (context) => MovieCubit()..fetchPlayingNowMovies(),
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
            BlocBuilder<MovieCubit, BlocState<List<MovieEntity>>>(
              builder: (context, state) {
                final cubit = context.read<MovieCubit>();
                return RefreshIndicator(
                  onRefresh: () => cubit.fetchPlayingNowMovies(),
                  child: InfiniteList(
                    onFetchData: () {
                      cubit.fetchNextPlayingNowMovies();
                      print('onFetchData ${cubit.currentPage}');
                    },
                    isLoading: state.status == BlocStatus.loading,
                    itemCount: state.data?.length ?? 0,
                    separatorBuilder: (context, index) => const Divider(height: 0),
                    itemBuilder: (context, index) => ListTile(
                      title: Text( "${index+1} ${state.data?[index].title ?? '-'}"),
                    ),
                    hasReachedMax: cubit.currentPage >= 5,
                    hasError: state.status == BlocStatus.error,
                    errorBuilder: (context) => Center(
                      child: Text(state.errorMessage ?? 'Error is not found'),
                    ),
                  ),
                );
              }
            ),
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