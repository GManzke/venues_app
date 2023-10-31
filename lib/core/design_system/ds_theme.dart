import 'package:flutter/material.dart';

class DSTheme {
  static ThemeData get defaultTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(
            int.parse('0xFF9E035D'),
          ),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Color(int.parse('0xFF9E035D')),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        useMaterial3: true,
      );
}
