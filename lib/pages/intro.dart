import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apputskika2/components/button.dart';
import 'package:flutter_apputskika2/pages/menu_page.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cakealicious App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => const Intro(),
        '/menupage': (context) => const MenuPage(),
      },
    );
  }
}

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF383161),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Text(
              "KIKAKAKII CAKE",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 35,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('lib/images/2.png'),
            ),
            const SizedBox(height: 2),
            Text(
              "THE TASTE OF CAKE",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 37,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Welcome to the enchanting realm of cakes, where every slice a work of art.",
              style: TextStyle(
                color: Colors.grey[50],
                height: 2,
              ),
            ),
            const SizedBox(height: 10),
            MyButton(
              text: "Get Started",
              onTap: () {
                Navigator.pushNamed(context, '/menupage');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('WELCOME TO KIKAKAKII CAKE!'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        // Do nothing for now
                      },
                    ),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 4),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
