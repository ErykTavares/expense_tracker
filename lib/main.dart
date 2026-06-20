import 'package:expense_tracker/screens/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ColorScheme? get colorScheme => null;
  final primaryColor = const Color(0xffd32f2f);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white, // Text color on top of primary red
          secondary: Color(0xFFFF5252), // Bright Coral Red for accents
          onSecondary: Colors.white,
          error: Color(0xFFB00020), // Error Red
          onError: Colors.white,
          surface: Color(
            0xFFF5F5F5,
          ), // Very faint pinkish-white tint background
          onSurface: Colors.grey[900]!,
          // Dark gray for text on surface
        ),
      ),
      home: Expenses(),
    );
  }
}
