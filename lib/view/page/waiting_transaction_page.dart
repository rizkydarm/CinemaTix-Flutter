part of '_page.dart';

class WaitingTransactionPage extends StatelessWidget {
  const WaitingTransactionPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 10)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/success_animation.json',
                    repeat: false,
                    width: 200,
                    height: 200,
                    filterQuality: FilterQuality.medium,
                  ),
                  const SizedBox(height: 16,),
                  FilledButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    child: const Text('Back Home'),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImageView(
                    data: const Uuid().v4(),
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 100,)
                ],
              );
            }
          }
        ),
      ),
    );
  }
}