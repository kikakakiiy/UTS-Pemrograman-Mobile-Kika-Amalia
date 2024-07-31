import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 109, 5, 5),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 2),
            Text(
              "CALCULATOR KIKAKAKII",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset('lib/images/3.png'),
            ),
            const SizedBox(height: 2),
            Text(
              "SIMPLE AND EFFICIENT",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Experience precision and simplicity—your go-to tool for quick and accurate calculations is here!",
              style: TextStyle(
                color: Colors.grey[50],
                height: 2,
              ),
            ),
            const SizedBox(height: 25),
            MyButton(
              text: "Get Started",
              onTap: () {
                Navigator.pushNamed(context, '/calculator');
              },
            )
          ],
        ),
      ),
    );
  }
}
