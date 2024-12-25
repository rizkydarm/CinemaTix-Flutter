part of '_page.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {

    final scrollController = ScrollController();
    final showAppbarNotifier = ValueNotifier(false);

    bool isScrollingDown = false;

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
        }
      }
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
        }
      }

      if (scrollController.offset > 200 && !showAppbarNotifier.value) {
        showAppbarNotifier.value = true;
      } else if (scrollController.offset < 200 && showAppbarNotifier.value) {
        showAppbarNotifier.value = false;
      }
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: showAppbarNotifier,
              builder: (context, showAppbar, child) {
                return AnimatedContainer(
                  height: showAppbar ? 56.0 : 0.0,
                  duration: const Duration(milliseconds: 240),
                  child: child,
                );
              },
              child: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                flexibleSpace: const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Icon(Icons.attach_money_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text('Rp1.000.000',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.email_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: ColoredBox(
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Theme(
                              data: ThemeData(
                                iconButtonTheme: IconButtonThemeData(
                                  style: IconButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    foregroundColor: Colors.white
                                  )
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(width: 16,),
                                  Image.asset('assets/white_icon.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      if (AdaptiveTheme.of(context).brightness == Brightness.dark) {
                                        AdaptiveTheme.of(context).setLight();
                                      }
                                    },
                                    icon: const Icon(Icons.email_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (AdaptiveTheme.of(context).brightness == Brightness.light) {
                                        AdaptiveTheme.of(context).setDark();
                                      }
                                    },
                                    icon: const Icon(Icons.settings_outlined),
                                  )
                                ],
                              ),
                            ),
                            const Text('Rp1.000.000',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  WalletButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_upward_outlined),
                                    label: "Top Up",
                                  ),
                                  WalletButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.send_outlined),
                                    label: "Send",
                                  ),
                                  WalletButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_downward_outlined),
                                    label: "Request",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // body: ListView(
      //   controller: scrollController,
      //   children: [
      //     ... List.generate(20, (i) => SizedBox(height: 100,
      //       child: Divider(color: Colors.amber,),
      //     ))
      //   ],
      // )
    );
  }
}

class WalletButton extends StatelessWidget {
  
  const WalletButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed
  });

  final void Function() onPressed;
  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filled(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.white.withOpacity(0.2),
            fixedSize: const Size(50, 50),
            padding: EdgeInsets.zero,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))
            ),
          ),
          icon: icon,
        ),
        const SizedBox(height: 4,),
        Text(label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}