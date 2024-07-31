import 'package:flutter/material.dart';
import 'package:flutter_apputskika2/src/splash_screen.dart'; // Adjust import according to your project structure

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set SplashScreen as the home
    );
  }
}
