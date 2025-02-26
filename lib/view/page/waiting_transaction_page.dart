part of '_page.dart';

class WaitingTransactionPage extends StatelessWidget {
  const WaitingTransactionPage({super.key, required this.data});

  final TransactionEntity data;

  @override
  Widget build(context) {
    
    const limit = Duration(minutes: 30);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Transaction'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: QrisTicket(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/payment_logo/qris_logo.jpeg',
                          width: 80,
                        ),
                        Image.asset('assets/payment_logo/gpn_logo.png',
                          width: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    SizedBox(
                      height: 320,
                      child: Center(
                        child: ColoredBox(
                          color: Colors.white,
                          child: QrImageView(
                            data: generateLongString(512), 
                            version: QrVersions.auto,
                            size: 280,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No. Transaction:',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(data.noTransaction,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          const Text('Total Payment:',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(data.totalPayment,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24,),
          if (!GoRouter.of(context).canPop())
            FilledButton(
              onPressed: () {
                context.go('/home');
              },
              child: const Text('Go Home'),
            ),
        ],
      )
    );
  }
}

class QrisTicket extends StatelessWidget {
  const QrisTicket({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.26),
            blurRadius: 10.0,
            spreadRadius: 3.0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        width: 360,
        height: 540,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ClipPath(
            clipper: CouponClipper(),
            child: ColoredBox(
              color: Colors.white,
              child: CustomPaint(
                painter: RedTrianglePainter(),
                child: child,
              )
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper for Coupon Shape
class CouponClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final width = size.width;
    final height = size.height;
    const arcRadius = 10.0; // Radius of the arcs
    const arcCount = 10; // Number of arcs
    final arcSpacing = width / (arcCount + 1); // Spacing between arcs

    // Start from the top-left corner
    path.moveTo(0, 0);

    // Loop to create 3 arcs on the top edge
    for (int i = 1; i <= arcCount; i++) {
      final x = arcSpacing * i;

      // Move to the start of the arc
      path.lineTo(x - arcRadius, 0);

      // Draw the arc
      path.arcToPoint(
        Offset(x + arcRadius, 0),
        radius: const Radius.circular(arcRadius),
        clockwise: false,
      );
    }

    // Draw the right edge
    path.lineTo(width, 0);
    path.lineTo(width, height);

    // Loop to create 3 arcs on the bottom edge
    for (int i = arcCount; i >= 1; i--) {
      final x = arcSpacing * i;

      // Move to the start of the arc
      path.lineTo(x + arcRadius, height);

      // Draw the arc
      path.arcToPoint(
        Offset(x - arcRadius, height),
        radius: const Radius.circular(arcRadius),
        clockwise: false,
      );
    }

    // Draw the left edge
    path.lineTo(0, height);
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Return true if the shape needs to be redrawn dynamically
  }
}

class RedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Left triangle
    const offsetX = 0;
    const offsetY = 80.0;
    const side = 200.0;
    final leftPath = Path()
      ..moveTo(offsetX+0, offsetY+0)
      ..lineTo(offsetX+side, offsetY+0)
      ..lineTo(offsetX+0, offsetY+side)
      ..close();
    canvas.drawPath(leftPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
