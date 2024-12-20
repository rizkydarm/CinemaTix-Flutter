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

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: TextButton.icon(
          icon: const Icon(Icons.location_on_outlined, size: 30,),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ChangeCityAlertDialog(selectedCityNotifier: selectedCityNotifier);
              },
            );
          },
          label: ValueListenableBuilder(
            valueListenable: selectedCityNotifier,
            builder: (context, value, child) {
              return Text(value?.name ?? 'Bandung',
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
          child: Text('Next'),
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
    );
  }
}

class ChangeCityAlertDialog extends StatelessWidget {
  const ChangeCityAlertDialog({
    required this.selectedCityNotifier,
    super.key,
  });

  final ValueNotifier<CityEntity?> selectedCityNotifier;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change City'),
      content: const Text('Do you want to change the city?'),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            context.pop();
            showModalBottomSheet(
              useSafeArea: true,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
              return SearchCitySheet(selectedCityNotifier: selectedCityNotifier);
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
    required this.selectedCityNotifier,
    super.key,
  });

  final ValueNotifier<CityEntity?> selectedCityNotifier;

  @override
  Widget build(BuildContext context) {
    
    context.read<CityCubit>().fetchCities();

    final searchNotifier = ValueNotifier<String?>(null);

    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
      return BlocBuilder<CityCubit, BlocState>(
        builder: (context, state) {
          final cities = (state is SuccessState<List<CityEntity>>) ? state.data : [];
          return Column(
            children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  searchNotifier.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search City',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: () {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorState) {
                  return Center(child: Text(state.message));
                } else if (state is SuccessState<List<CityEntity>>) {
                  return ValueListenableBuilder(
                    valueListenable: searchNotifier,
                    builder: (context, value, child) {
                      final filteredCities = value != null ? cities.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList() : cities;
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: filteredCities.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(filteredCities[index].name),
                            onTap: () {
                              selectedCityNotifier.value = filteredCities[index];
                              context.pop();
                            },
                          );
                        },
                      );
                    }
                  );
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              }(),
            ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     TextButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     child: const Text('Cancel'),
              //     ),
              //     TextButton(
              //     onPressed: () {
              //       // Handle city selection confirmation
              //       Navigator.pop(context);
              //     },
              //     child: const Text('Choose'),
              //     ),
              //   ],
              //   ),
              // ),
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