part of '_page.dart';

class WaitingTransactionPage extends StatelessWidget {
  const WaitingTransactionPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.go('/home');
          },
          child: Text('Back Home'),
        ),
      ),
    );
  }
}