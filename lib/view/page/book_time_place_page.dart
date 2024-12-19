part of '_page.dart';

class BookTimePlacePage extends StatelessWidget {

  final String movieId;
  
  const BookTimePlacePage({super.key,
    required this.movieId,
  });
  
  @override
  Widget build(BuildContext context) {

    final now = DateTime.now();
    final sevenDays = <String>[];
    for (int i = 0; i < 7; i++) {
      final temp = now.add(Duration(days: i+1));
      final formattedDate = DateFormat('EEE, d').format(temp);
      sevenDays.add(formattedDate);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Time'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("Choose Date",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
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
                      width: 120,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: value != null && value == i ? MyColors.v400 : MyColors.base
                        ),
                        onPressed: () {
                          setState(i);
                        },
                        child: Text(sevenDays[i]),
                      ),
                    );
                  },
                );
              }
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("Choose Place & Time",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      )
    );
  }
}