import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Import the OnBoarding screen from the correct file
import 'package:flutter_apputskika2/src/board.dart'; // Adjust the import according to your project structure

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Color.fromARGB(255, 252, 250, 131),
    ).animate(_controller);

    // Navigate to the OnBoarding screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBoarding()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3937bf),
      body: Center(
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return SpinKitCircle(
              color: _colorAnimation.value ??
                  const Color.fromARGB(255, 255, 97, 97),
              size: 100,
            );
          },
        ),
      ),
    );
  }
}
