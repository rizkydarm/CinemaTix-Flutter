import 'package:flutter/material.dart';

import '_main.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

void main() {
  FlavorConfig(
    name: "UAT",
    color: Colors.blue,
    location: BannerLocation.topStart,
    variables: {
      "baseUrl": "https://www.example.com",
    },
  );
  runMain();
}