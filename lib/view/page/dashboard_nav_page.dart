part of '_page.dart';

class DashboardNavPage extends StatelessWidget {
  const DashboardNavPage({super.key});

  @override
  Widget build(BuildContext context) {

    final indexNotifier = ValueNotifier<int>(0);
    final pageController = PageController(initialPage: 0);

    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: indexNotifier,
        builder: (context, value, child) {
          return BottomNavigationBar(
            currentIndex: value,
            onTap: (index) {
              indexNotifier.value = index;
              pageController.animateToPage(index, 
                duration: const Duration(milliseconds: 240), 
                curve: Curves.easeOut
              );
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
      body: PageView(
        physics: const PageScrollPhysics(),
        controller: pageController,
        onPageChanged: (value) => indexNotifier.value = value,
        children: const [
          HomePage(),
          WalletPage(),
        ],
      )
    );
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: const Center(
        child: Text('Wallet Page'),
      ),
    );
  }
}