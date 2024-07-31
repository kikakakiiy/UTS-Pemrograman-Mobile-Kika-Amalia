import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home_page.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final LiquidController obController = LiquidController();
  int currentPage = 0;

  void _navigateToHomePage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      },
    );

    // Simulate a delay to show the spinner before navigating
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop(); // Close the spinner dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Container(
        color: Color(0xff3937bf),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title above the image
                Text(
                  'CakeMate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30, // Adjust the font size as needed
                  ),
                ),
                SizedBox(
                    height:
                        5), // Add some space between the title and the image

                // Image below the title
                Image.asset('assets/images/rev.png'),

                // Description below the image
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Best Digital Solution',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "CakeMate combines functionality with simplicity, offering a user-friendly interface that makes cake shopping, calculation, and conversion a breeze.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 40.0,
              right: 20.0,
              child: OutlinedButton(
                onPressed: _navigateToHomePage,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Color(0xff27b56f),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'KIKAKAKII CAKE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40, // Adjust the font size as needed
                  ),
                ),
                SizedBox(height: 3),
                Image.asset('assets/images/6.png'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cmon! To CakeShop!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Order your favorite cakes effortlessly through our app, and enjoy a hassle-free shopping experience.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 40.0,
              right: 20.0,
              child: OutlinedButton(
                onPressed: _navigateToHomePage,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Color(0xfff46d37),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Convert Pro',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30, // Adjust the font size as needed
                  ),
                ),
                SizedBox(height: 3),
                Image.asset(
                  'assets/images/1.png',
                  width: 400, // Sesuaikan dengan ukuran yang diinginkan
                  height: 400, // Sesuaikan dengan ukuran yang diinginkan
                  fit: BoxFit.contain, // Menyesuaikan gambar di dalam kotak
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Simplify Your Conversions with CakeMate!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Need quick and accurate conversions? CakeMate's conversion menu is here to make your life easier.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 40.0,
              right: 20.0,
              child: OutlinedButton(
                onPressed: _navigateToHomePage,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: obController,
            onPageChangeCallback: (index) {
              setState(() {
                currentPage = index;
              });
            },
            enableLoop: true,
            slideIconWidget: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: MediaQuery.of(context).size.width / 2 -
                35, // Center horizontally
            child: OutlinedButton(
              onPressed: () => obController.animateToPage(
                page: currentPage + 1 > pages.length - 1 ? 0 : currentPage + 1,
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black26),
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                backgroundColor: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 226, 226, 190),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: MediaQuery.of(context).size.width / 2 -
                35, // Center horizontally
            child: AnimatedSmoothIndicator(
              count: pages.length,
              activeIndex: currentPage,
              effect: ExpandingDotsEffect(
                activeDotColor: Color(0xff272727),
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
