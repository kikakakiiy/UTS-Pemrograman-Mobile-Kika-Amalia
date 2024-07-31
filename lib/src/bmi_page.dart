import 'package:flutter/material.dart';
import 'package:flutter_apputskika2/pages/menuconvert/bmicalculator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BMIPageIntro(),
        '/BMIPage': (context) => BMIPage(),
      },
    );
  }
}

class BMIPageIntro extends StatelessWidget {
  const BMIPageIntro({super.key});

  @override
  Widget build(BuildContext context) {
    // Timer untuk menunggu beberapa detik sebelum navigasi
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BMIPage()),
      );
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 177, 212, 155),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 2),
            Text(
              "FitBMI",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset('assets/images/15.png'),
            ),
            const SizedBox(height: 2),
            Text(
              "CHECK YOUR BMI",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Welcome to FitBMI, your companion for tracking BMI. Monitor your health and get personalized fitness and nutrition tips.",
              style: TextStyle(
                color: Colors.grey[50],
                height: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
