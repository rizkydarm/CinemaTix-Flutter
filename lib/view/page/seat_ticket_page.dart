part of '_page.dart';

class SeatTicketPage extends StatelessWidget {
  
  const SeatTicketPage({super.key});

  @override
  Widget build(BuildContext context) {

    final ValueNotifier<int> selectedSeatCount = ValueNotifier(0);
    List<(int, int)> selectedPositions = [];

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: const Text('Select Seat'),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ValueListenableBuilder<int>(
          valueListenable: selectedSeatCount,
          builder: (context, value, child) {
            return FilledButton(
              onPressed: value > 0 ? () {
                context.read<CheckoutCubit>().selectedSeatsEntity = SelectedSeatsEntity(
                  total: selectedSeatCount.value,
                  positions: selectedPositions
                );
                context.push('/checkout');
              } : null,
              child: Text(value > 0 ? 'Checkout ($value)' : 'Checkout'),
            );
          }
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                const Text('Available'),
                const SizedBox(width: 16,),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                const Text('Selected'),
                const SizedBox(width: 16,),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                const Text('Booked'),
                const SizedBox(width: 16,),
            
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: ListenableProvider.value(
              value: selectedSeatCount,
              child: Provider.value(
                value: selectedPositions,
                child: const TwoDimensionalScroll(),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: Center(child: Text('Screen', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TwoDimensionalScroll extends StatelessWidget {
  const TwoDimensionalScroll({super.key});

  @override
  Widget build(BuildContext context) {

    final selectedSeatCount = Provider.of<ValueNotifier<int>>(context);
    final selectedPositions = Provider.of<List<(int, int)>>(context);

    const row = 28;
    const col = 12;

    final booked = [(1, 2), (1, 3), (1, 4), (1, 5)];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: List.generate(row, (rowIndex) {
            return Column(
              children: List.generate(col, (colIndex) {
                final isBooked = booked.any((e) => e.$1 == rowIndex && e.$2 == colIndex);
                return Padding(
                  padding: const EdgeInsets.all(2.4),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulValueBuilder<bool>(
                      initialValue: false,
                      builder: (context, value, setState) {
                        return Material(
                          shape: RoundedRectangleBorder(
                            side: isBooked ? BorderSide.none : BorderSide(
                              color: value == false ? Colors.blue : Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: isBooked ? Colors.grey : (value == false ? Colors.white : Colors.blue),
                          clipBehavior: Clip.antiAlias,
                          child: isBooked ? null : InkWell(
                            splashColor: Colors.blue.withOpacity(0.4),
                            onTap: () {
                              setState(!value!);
                              selectedSeatCount.value = selectedSeatCount.value + (value ? -1 : 1);
                              
                              if (selectedPositions.contains((rowIndex, colIndex))) {
                                selectedPositions.remove((rowIndex, colIndex));
                              } else {
                                selectedPositions.add((rowIndex, colIndex));
                              }
                              
                            },
                          ),
                        );
                      }
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
