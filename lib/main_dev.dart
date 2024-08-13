import 'package:flutter/material.dart';

import '_main.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  FlavorConfig(
    name: "DEV",
    color: Colors.red,
    location: BannerLocation.topStart,
    variables: {
      "baseUrl": "https://www.example.com",
    },
  );
  runMain();
}