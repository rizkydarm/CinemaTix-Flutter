part of '_page.dart';

class DashboardNavPage extends StatelessWidget {
  const DashboardNavPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StatefulValueBuilder<int>(
        initialValue: 0,
        builder: (context, value, setState) {
          return BottomNavigationBar(
            currentIndex: value ?? 0,
            onTap: (index) {
              setState(index);
              navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex,);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'Wallet',
              )
            ],
          );
        }
      ),
      body: navigationShell,
    );
  }
}