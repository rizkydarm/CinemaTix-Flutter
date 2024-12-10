part of '_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  final scrollController = ScrollController();

  bool _showAppbar = false; 
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
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

      if (scrollController.offset > 160) {
        setState(() => _showAppbar = true);
      } else {
        setState(() => _showAppbar = false);
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
      child: Column(
        children: <Widget>[
          AnimatedContainer(
            height: _showAppbar ? 56.0 : 0.0,
            duration: const Duration(milliseconds: 240),
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
                    ColoredBox(
                      color: Theme.of(context).primaryColor,
                      child: SizedBox(
                        height: 200,
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
                                  IconButton(
                                    onPressed: () {
                                      
                                    },
                                    icon: const Icon(Icons.email_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      
                                    },
                                    icon: const Icon(Icons.settings_outlined),
                                  )
                                ],
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(Icons.attach_money_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                Text('Rp1.000.000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                              ],
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
                    ... List.generate(20, (i) => SizedBox(height: 100,
                      child: Divider(color: Colors.amber,),
                    ))
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