import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFF03D79),
          secondary: Color(0xFF76A8D5),
          tertiary: Color(0xFF000000),
        ),
        fontFamily: 'Helvetica Neue',
      );
}
