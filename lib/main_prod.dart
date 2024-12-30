import '_main.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

Future<void> main() async {
  FlavorConfig(
    name: "PROD",
    variables: {
      "baseUrl": "https://www.example.com",
    },
  );
  await runMain();
}