part of '_page.dart';

class SeatTicketPage extends StatelessWidget {
  
  const SeatTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 0, 
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 600,
            child: TwoDimensionalScroll()
          ),
        ],
      ),
    );
  }
}

class TwoDimensionalScroll extends StatelessWidget {
  const TwoDimensionalScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: List.generate(10, (rowIndex) {
            return Column(
              children: List.generate(10, (colIndex) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50, // Width of each square
                    height: 50, // Height of each square
                    child: ColoredBox(
                      color: Colors.primaries[(rowIndex + colIndex) % Colors.primaries.length],
                      child: Center(
                        child: Text(
                          '[$rowIndex, $colIndex]',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
