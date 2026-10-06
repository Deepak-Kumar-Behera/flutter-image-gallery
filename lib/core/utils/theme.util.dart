import 'package:flutter/material.dart';

class UTheme {
  UTheme._();

  static final ThemeData lightTheme = _theme(Brightness.light);
  static final ThemeData darkTheme = _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: brightness);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
    );
  }
}
