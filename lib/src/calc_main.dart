import 'package:flutter/material.dart';
import 'package:flutter_apputskika2/pages/calculator_isi.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'components/button.dart';
import 'intro_calc.dart';
//import '../pages/calculator_isi.dart';

// void main() {
//   runApp(const MyAppCalc());
// }

class MyAppCalc extends StatelessWidget {
  const MyAppCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => const IntroPage(),
        '/calculator': (context) => const CalculatorIsiPage(),
      },
    );
  }
}
