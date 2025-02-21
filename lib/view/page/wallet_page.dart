part of '_page.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {

    final scrollController = ScrollController();
    final showAppbarNotifier = ValueNotifier(false);

    bool isScrollingDown = false;

    context.read<WalletCubit>().fetchAllTransaction();

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
      backgroundColor: Colors.grey.shade200,
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
                                  GestureDetector(
                                    onDoubleTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Logout'),
                                            content: const Text('Are you sure you want to logout?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context.read<AuthCubit>().logout().whenComplete(() {
                                                    if (context.mounted) {
                                                      context.go('/login');
                                                    }
                                                  });
                                                },
                                                child: const Text('Logout'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Image.asset('assets/white_icon.png',
                                      width: 48,
                                      height: 48,
                                    ),
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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text("Last Transactions",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    // const SizedBox(height: 16,),
                    BlocBuilder<WalletCubit, BlocState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        else if (state is SuccessState) {
                          final data = state.data as List<TransactionEntity>;
                          if (data.isNotEmpty) {
                            return Column(
                              children: List.generate(data.length > 10 ? 10 : data.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    onTap: () {
                                      context.push('/waiting_trans', extra: data[index]);
                                    },
                                    tileColor: Theme.of(context).cardColor,
                                    title: Text(data[index].movie.title ?? '-',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    subtitle: Text(data[index].totalPayment),
                                    trailing: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: ColoredBox(
                                        color: switch (data[index].status.toLowerCase()) {
                                          'waiting' => Colors.orange.withOpacity(0.2),
                                          'success' => Colors.green.withOpacity(0.2),
                                          'failed' => Colors.red.withOpacity(0.2),
                                          _ => Colors.grey.withOpacity(0.2),
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: switch (data[index].status.toLowerCase()) {
                                            'waiting' => const Text('Waiting', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                            'success' => const Text('Success', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                            'failed' => const Text('Failed', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                            _ => const Text('Unknown', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                                          } 
                                        ),
                                      ),
                                    ),
                                  )
                                );
                              })
                            );
                          } else {
                            return const SizedBox(
                            height: 100,
                            child: Center(child: Text('The transactions are still empty')));
                          }
                        } else {
                          return const SizedBox(
                            height: 100,
                            child: Center(child: Text('Something went wrong')));
                        }
                      },
                    ) 
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