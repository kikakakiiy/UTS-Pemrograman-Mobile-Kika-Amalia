import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_apputskika2/pages/menuconvert/bmicalculator.dart';
import 'store_page.dart';
import 'calc_main.dart';
import 'convert_menu.dart';
import 'board.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;

  final List<Widget> _pages = [
    HomeContent(),
    StorePage(),
    MyAppCalc(),
    BMICalculatorApp(),
    MyAppConvert(),
  ];

  void _onTap(int index) {
    _showProgressDialog(() {
      setState(() {
        _currentIndex = index;
      });
    });
  }

  void _showProgressDialog(VoidCallback onComplete) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(),
                SizedBox(height: 20),
                Text('Wait a minute...', textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
    );

    // Simulate a network delay or processing time
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop(); // Close the dialog
      onComplete(); // Navigate to the new page
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  AppBar? _buildAppBar() {
    if (_currentIndex != 0) return null;
    return AppBar(
      backgroundColor:
          _isDarkMode ? Colors.black : Color.fromARGB(255, 255, 202, 235),
      title: Text('Home Page'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnBoarding()),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            // Background content
            _currentIndex == 0
                ? Positioned.fill(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: HomeContent(),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment
                                .centerRight, // Adjust alignment if needed
                            child: SizedBox(
                              height: 370,
                              width: 370, // Set the desired height here
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'assets/images/16.png', // Ensure the image exists
                                  fit: BoxFit
                                      .cover, // Adjust this as needed (cover, contain, etc.)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Positioned.fill(
                    child: _pages[_currentIndex],
                  ),
            // Theme toggle button
            if (_currentIndex == 0)
              Positioned(
                top: MediaQuery.of(context).padding.top +
                    kToolbarHeight -
                    80, // Adjust this value as needed
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ThemeToggleButton(
                    isDarkMode: _isDarkMode,
                    toggleTheme: _toggleTheme,
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: _currentIndex,
          backgroundColor: _isDarkMode
              ? Colors.grey[900]!
              : Color.fromARGB(255, 255, 202, 235),
          color:
              _isDarkMode ? Colors.black : Color.fromARGB(255, 241, 105, 128),
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.store, size: 30, color: Colors.white),
            Icon(Icons.calculate, size: 30, color: Colors.white),
            Icon(Icons.monitor_weight, size: 30, color: Colors.white),
            Icon(Icons.swap_horiz_rounded, size: 30, color: Colors.white),
          ],
          onTap: _onTap,
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Align the Cake button to the right
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0), // Align to the right
            child: CircleMenuButton(
              icon: Icons.store,
              label: 'Cake',
              onPressed: () {
                final homePageState =
                    context.findAncestorStateOfType<_HomePageState>();
                homePageState?._onTap(1);
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        CircleMenuButton(
          icon: Icons.calculate,
          label: 'Calculator',
          onPressed: () {
            final homePageState =
                context.findAncestorStateOfType<_HomePageState>();
            homePageState?._onTap(2);
          },
        ),
        SizedBox(height: 20),
        CircleMenuButton(
          icon: Icons.monitor_weight,
          label: 'BMI',
          onPressed: () {
            final homePageState =
                context.findAncestorStateOfType<_HomePageState>();
            homePageState?._onTap(3);
          },
        ),
        SizedBox(height: 20),
        // Align the Konversi button to the right
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0), // Align to the right
            child: CircleMenuButton(
              icon: Icons.swap_calls_rounded,
              label: 'Konversi',
              onPressed: () {
                final homePageState =
                    context.findAncestorStateOfType<_HomePageState>();
                homePageState?._onTap(4);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CircleMenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  CircleMenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
            backgroundColor: Colors.purple, // Button color changed to purple
          ),
          child:
              Icon(icon, size: 50, color: Colors.white), // Icon color is white
        ),
        SizedBox(height: 10),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

class ThemeToggleButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  ThemeToggleButton({required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Light"),
          SizedBox(width: 8.0),
          GestureDetector(
            onTap: toggleTheme,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 70,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode ? Colors.grey[700] : Colors.yellow,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.wb_sunny,
                        color: isDarkMode ? Colors.grey : Colors.blue,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.nights_stay,
                        color: isDarkMode ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    alignment: isDarkMode
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                      child: Icon(
                        isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
                        color: isDarkMode ? Colors.blue : Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Text("Dark"),
        ],
      ),
    );
  }
}
