import 'package:black_jack/screens/black_jack_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// This is a comment from GitHub.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
        ),
      ),
      home: BlackJackScreen(),
    );
  }
}
