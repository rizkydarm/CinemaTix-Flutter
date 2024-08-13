import '_main.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  FlavorConfig(
    name: "PROD",
    variables: {
      "baseUrl": "https://www.example.com",
    },
  );
  runMain();
}