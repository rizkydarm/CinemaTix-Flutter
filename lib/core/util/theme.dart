part of '../_core.dart';

class MyColors {
  const MyColors._();

  static const Color v900 = Color(0xFF005283);
  static const Color v800 = Color(0xFF0072A4);
  static const Color v700 = Color(0xFF0083B8);
  static const Color base = Color(0xFF0097CA);
  static const Color v500 = Color(0xFF00A4D7);
  static const Color v400 = Color(0xFF00B2DC);
  static const Color v300 = Color(0xFF09C0E0);
  static const Color v200 = Color(0xFF66D3E9);
  static const Color v100 = Color(0xFFA5E5F2);

  static const MaterialColor material = MaterialColor(0xFF0097CA, {
    50: MyColors.v100,
    100: MyColors.v100,
    200: MyColors.v200,
    300: MyColors.v300,
    400: MyColors.v400,
    500: MyColors.v500,
    600: MyColors.base,
    700: MyColors.v700,
    800: MyColors.v800,
    900: MyColors.v900,
  });
}

class MyTheme {

  MyTheme._();

  final theme = ThemeData(
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold
        )
      ),
    ),
    // iconButtonTheme: IconButtonThemeData(
    //   style: IconButton.styleFrom(
    //     foregroundColor: Colors.grey
    //   )
    // ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
    ),
    useMaterial3: true,
  );
}