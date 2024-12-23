part of '_page.dart';

class BookTimePlacePage extends StatelessWidget {

  final String movieId;
  
  const BookTimePlacePage({super.key,
    required this.movieId,
  });
  
  @override
  Widget build(BuildContext context) {

    context.read<BookTimePlaceCubit>().fetchAllCinemaMall();
    
    final selectedCityNotifier = ValueNotifier<CityEntity?>(null);

    return ListenableProvider.value(
      value: selectedCityNotifier,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: false,
          title: TextButton.icon(
            icon: const Icon(Icons.location_on_outlined, size: 30,),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            onPressed: () {
              final notifier = Provider.of<ValueNotifier<CityEntity?>>(context, listen: false);
              showDialog(
                context: context,
                useRootNavigator: true,
                builder: (_) => ListenableProvider.value(
                  value: notifier,
                  child: const ChangeCityAlertDialog()
                ),
              );
            },
            label: Consumer<ValueNotifier<CityEntity?>>(
              builder: (context, value, child) {
                return Text(value.value?.name ?? 'Bandung',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                );
              }
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: FilledButton(
            onPressed: () {},
            child: const Text('Next'),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
             Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Choose Date",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const DayDateOptionCips(),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Choose Place & Time",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<BookTimePlaceCubit, BlocState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const SizedBox(
                    height: 300,
                    child: Center(child: CircularProgressIndicator()));
                }
                else if (state is ErrorState) {
                  return SizedBox(
                    height: 300,
                    child: Center(child: Text(state.message)));
                }
                else if (state is SuccessState<List<CinemaMallEntity>>) {
                  final places = state.data;
                  return StatefulValueBuilder<String?>(
                    builder: (context, value, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (CinemaMallEntity place in places) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text('${place.mall} - ${place.cinema}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: place.times.length,
                                  separatorBuilder: (context, i) => const SizedBox(width: 8,),
                                  itemBuilder: (context, i) {
                                    final itemKey = '${place.props}${place.times[i]}';
                                    return SizedBox(
                                      width: 90,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: value != null && value == itemKey ? Colors.white : MyColors.v400,
                                          backgroundColor: value != null && value == itemKey ? MyColors.v400 : null,
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                          side: value != null && value == itemKey ? null : const BorderSide(color: MyColors.v400),
                                        ),
                                        onPressed: () {
                                          if (itemKey != value) {
                                            setState(itemKey);
                                          }
                                        },
                                        child: Text(place.times[i]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]
                        ],
                      );
                    }
                  );
                } else {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: Text('Something went wrong')
                    )
                  );
                }
              }
            )
          ],
        )
      ),
    );
  }
}

class ChangeCityAlertDialog extends StatelessWidget {
  const ChangeCityAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {  
    return AlertDialog(
      title: const Text('Change City'),
      content: const Text('Do you want to change the city?'),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            context.pop();
            final notifier = Provider.of<ValueNotifier<CityEntity?>>(context, listen: false);
            showModalBottomSheet(
              useSafeArea: true,
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              builder: (context) {
                return ListenableProvider.value(
                  value: notifier,
                  child: const SearchCitySheet()
                );
              },
            );
          },
          child: const Text('Search City'),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Search My Location'),
        ),
      ],
    );
  }
}

class SearchCitySheet extends StatelessWidget {
  const SearchCitySheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    context.read<CityCubit>().fetchCities();

    final searchNotifier = ValueNotifier<String?>(null);

    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext sheetContext, ScrollController scrollController) {
        return BlocBuilder<CityCubit, BlocState>(
          builder: (blocContext, state) {
            final cities = (state is SuccessState<List<CityEntity>>) ? state.data : [];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      searchNotifier.value = value;
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search City',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: switch (state) {
                    LoadingState _ => const Center(child: CircularProgressIndicator()),
                    ErrorState _ => Center(child: Text(state.message)),
                    SuccessState<List<CityEntity>> _ => ValueListenableBuilder(
                      valueListenable: searchNotifier,
                      builder: (localContext, value, child) {
                        final filteredCities = value != null ? cities.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList() : cities;
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: filteredCities.length,
                          itemBuilder: (listContext, index) {
                            return ListTile(
                              title: Text(filteredCities[index].name),
                              onTap: () {
                                final selectedCityNotifier = context.read<ValueNotifier<CityEntity?>>();
                                selectedCityNotifier.value = filteredCities[index];
                                sheetContext.pop();
                              },
                            );
                          },
                        );
                      }
                    ),
                    _ => const Center(child: Text('Something went wrong')),
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }
}

class DayDateOptionCips extends StatelessWidget {
  const DayDateOptionCips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sevenDays = context.read<BookTimePlaceCubit>().createSevenDays();
    return SizedBox(
      height: 40,
      child: StatefulValueBuilder<int?>(
        builder: (context, value, setState) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: sevenDays.length,
            separatorBuilder: (context, i) => const SizedBox(width: 8,),
            itemBuilder: (context, i) {
              return SizedBox(
                width: 112,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: value != null && value == i ? Colors.white : MyColors.v400,
                    backgroundColor: value != null && value == i ? MyColors.v400 : null,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    side: value != null && value == i ? null : const BorderSide(color: MyColors.v400),
                  ),
                  onPressed: () {
                    setState(i);
                  },
                  child: Text(sevenDays[i].toUpperCase()),
                ),
              );
            },
          );
        }
      ),
    );
  }
}