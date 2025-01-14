part of '_page.dart';

class BookTimePlacePage extends StatelessWidget {

  final String movieId;
  
  const BookTimePlacePage({super.key,
    required this.movieId,
  });
  
  @override
  Widget build(BuildContext context) {

    context.read<BookTimePlaceCubit>().fetchAllCinemaMall();
    
    final selectedCityNotifier = ValueNotifier<CityEntity?>(CityEntity(id: '10', name: 'Bandung'));
    final selectedCinemaNotifier = ValueNotifier<CinemaMallEntity?>(null);
    final selectedDatePlaceNotifier = ValueNotifier<(String?, String?)>((null, null));

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: TextButton.icon(
          icon: const Icon(Icons.location_on_outlined, size: 30,),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          onPressed: () async {
            final result = await showDialog(
              context: context,
              useRootNavigator: true,
              builder: (_) => const ChangeCityAlertDialog()
            );
            if (result is CityEntity) {
              selectedCityNotifier.value = result;
            }
          },
          label: ValueListenableBuilder(
            valueListenable: selectedCityNotifier,
            builder: (context, value, child) => Text(value?.name ?? '-',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold
              ),
            )
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ValueListenableBuilder<(String?, String?)>(
          valueListenable: selectedDatePlaceNotifier,
          builder: (context, value, child) {
            return FilledButton(
              onPressed: value.$1 != null && value.$2 != null ? () {

                if (selectedCityNotifier.value == null) {
                  return;
                }

                if (selectedCinemaNotifier.value == null) {
                  return;
                }

                if (selectedDatePlaceNotifier.value.$1 == null || selectedDatePlaceNotifier.value.$2 == null) {
                  return;
                }


                context.read<CheckoutCubit>().selectedCinemaMall = SelectedCityCinemaMallEntity(
                  city: selectedCityNotifier.value!,
                  cinemaMall: selectedCinemaNotifier.value!,
                );

                context.read<CheckoutCubit>().selectedDateTimeBookingEntity = SelectedDateTimeBookingEntity(
                  date: selectedDatePlaceNotifier.value.$1!,
                  time: selectedDatePlaceNotifier.value.$2!,
                );

                context.push('/seat_ticket');

              } : null,
              child: const Text('Next'),
            );
          }
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
          DayDateOptionCips(
            selectedDatePlaceNotifier: selectedDatePlaceNotifier,
          ),
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
                                itemCount: place.times?.length ?? 0,
                                separatorBuilder: (context, i) => const SizedBox(width: 8,),
                                itemBuilder: (context, i) {
                                  final itemKey = '${place.props}${place.times?[i]}';
                                  return SizedBox(
                                    width: 90,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: value != null && value == itemKey ? Colors.white : Colors.blue.shade400,
                                        backgroundColor: value != null && value == itemKey ? Colors.blue.shade400 : null,
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                        side: value != null && value == itemKey ? null : BorderSide(color: Colors.blue.shade400),
                                      ),
                                      onPressed: () {
                                        if (itemKey != value) {
                                          setState(itemKey);
                                          selectedDatePlaceNotifier.value = (selectedDatePlaceNotifier.value.$1, place.times?[i] ?? '-');
                                        } else {
                                          setState(null);
                                          selectedDatePlaceNotifier.value = (selectedDatePlaceNotifier.value.$1, null);
                                        }
                                        selectedCinemaNotifier.value = place;
                                      },
                                      child: Text(place.times?[i] ?? '-'),
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
          onPressed: () async {
            final result = await showModalBottomSheet(
              useSafeArea: true,
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              builder: (context) => const SearchCitySheet(),
            );
            if (result is CityEntity) {
              if (context.mounted) {
                context.pop(result);
              }
            }
          },
          child: const Text('Search City'),
        ),
        TextButton(
          onPressed: () async {
            LocationPermission permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
            }
            if (context.mounted) {
              context.pop();
            }
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
      initialChildSize: 0.85,
      builder: (sheetContext, scrollController) {
        return BlocBuilder<CityCubit, BlocState>(
          builder: (blocContext, state) {
            final cities = (state is SuccessState<List<CityEntity>>) ? state.data : <CityEntity>[];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) => searchNotifier.value = value,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search City',
                      hintStyle: const TextStyle(color: Colors.grey),
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
                                sheetContext.pop(filteredCities[index]);
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
    required this.selectedDatePlaceNotifier,
    super.key,
  });

  final ValueNotifier<(String?, String?)> selectedDatePlaceNotifier;

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
                    foregroundColor: value != null && value == i ? Colors.white : Colors.blue.shade400,
                    backgroundColor: value != null && value == i ? Colors.blue.shade400 : null,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    side: value != null && value == i ? null : BorderSide(color: Colors.blue.shade400),
                  ),
                  onPressed: () {
                    if (value != i) {
                      setState(i);
                      selectedDatePlaceNotifier.value = (sevenDays[i], selectedDatePlaceNotifier.value.$2);
                    } else {
                      setState(null);
                      selectedDatePlaceNotifier.value = (null, selectedDatePlaceNotifier.value.$2);
                    }
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