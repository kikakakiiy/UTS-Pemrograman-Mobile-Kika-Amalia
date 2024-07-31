import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_apputskika2/pages/menuconvert/bmicalculator.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:async';
import 'bmi_detail_screen.dart';
import 'package:flutter_apputskika2/src/convert_menu.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => BMIPageIntro()),
        GetPage(name: '/BMIPage', page: () => BMIPage()),
      ],
    );
  }
}

class BMIPageIntro extends StatelessWidget {
  const BMIPageIntro({super.key});

  @override
  Widget build(BuildContext context) {
    // Timer untuk menunggu beberapa detik sebelum navigasi
    Timer(Duration(seconds: 3), () {
      Get.toNamed('/BMIPage');
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

class BMICalculatorController extends GetxController {
  var height = 150.0.obs;
  var weight = 60.obs;
  var age = 20.obs;
  var selectedGender = Gender.male.obs;
}

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final BMICalculatorController bmiController =
      Get.put(BMICalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Color.fromARGB(255, 252, 214, 132),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MenuPage()), // Navigasi ke halaman ConvertMenu
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 247, 175),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gender Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        bmiController.selectedGender.value = Gender.male,
                    child: Obx(() => Container(
                          decoration: BoxDecoration(
                            color: bmiController.selectedGender.value ==
                                    Gender.male
                                ? const Color.fromARGB(255, 162, 201, 234)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.male, size: 80, color: Colors.black),
                              Text('Male', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          height: 120,
                        )),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        bmiController.selectedGender.value = Gender.female,
                    child: Obx(() => Container(
                          decoration: BoxDecoration(
                            color: bmiController.selectedGender.value ==
                                    Gender.female
                                ? Color.fromARGB(255, 217, 150, 172)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.female, size: 80, color: Colors.black),
                              Text('Female', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          height: 120,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Height Slider and Controls
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 217, 192, 227),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text('Height', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 16),
                        Obx(
                          () => Container(
                            height: 400,
                            child: SfSlider.vertical(
                              min: 50,
                              max: 250,
                              value: bmiController.height.value,
                              interval: 25,
                              showTicks: true,
                              showLabels: true,
                              enableTooltip: true,
                              minorTicksPerInterval: 5,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              inactiveColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              onChanged: (dynamic value) {
                                bmiController.height.value = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Weight Box
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 215, 175),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Weight (kg)', style: TextStyle(fontSize: 18)),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildRoundedButton(
                                  context,
                                  Icons.remove,
                                  () {
                                    if (bmiController.weight.value > 0) {
                                      bmiController.weight.value--;
                                    }
                                  },
                                ),
                                SizedBox(width: 16),
                                Obx(() => Text('${bmiController.weight.value}',
                                    style: TextStyle(fontSize: 18))),
                                SizedBox(width: 16),
                                _buildRoundedButton(
                                  context,
                                  Icons.add,
                                  () {
                                    bmiController.weight.value++;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      // Age Box
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 215, 175),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Age (years)', style: TextStyle(fontSize: 18)),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildRoundedButton(
                                  context,
                                  Icons.remove,
                                  () {
                                    if (bmiController.age.value > 0) {
                                      bmiController.age.value--;
                                    }
                                  },
                                ),
                                SizedBox(width: 16),
                                Obx(() => Text('${bmiController.age.value}',
                                    style: TextStyle(fontSize: 18))),
                                SizedBox(width: 16),
                                _buildRoundedButton(
                                  context,
                                  Icons.add,
                                  () {
                                    bmiController.age.value++;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Calculate Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                final heightInMeters = bmiController.height.value / 100;
                final bmi = bmiController.weight.value /
                    (heightInMeters * heightInMeters);
                final bmiResult = bmi.toStringAsFixed(1);
                String bmiCategory;

                if (bmi < 18.5) {
                  bmiCategory = "Underweight";
                } else if (bmi >= 18.5 && bmi < 23) {
                  bmiCategory = "Normal weight";
                } else if (bmi >= 23 && bmi < 30) {
                  bmiCategory = "Overweight";
                } else {
                  bmiCategory = "Obesity";
                }

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.orange,
                    title: Text(
                      'BMI Result',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'Your BMI is $bmiResult\nCategory: $bmiCategory',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BMIDetailScreen(
                                bmi: bmi,
                                category: bmiCategory,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'View Result',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Calculate BMI'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedButton(
      BuildContext context, IconData icon, VoidCallback onPressed) {
    return ClipOval(
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          splashColor: Color.fromARGB(255, 213, 186, 223),
          onTap: onPressed,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(icon, color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      ),
    );
  }
}

// class BMIDetailScreen extends StatelessWidget {
//   final double bmi;
//   final String category;

//   BMIDetailScreen({required this.bmi, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BMI Details'),
//       ),
//       body: Center(
//         child: Text('BMI: $bmi\nCategory: $category'),
//       ),
//     );
//   }
// }

// class MenuPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Menu Page'),
//       ),
//       body: Center(
//         child: Text('This is the Menu Page'),
//       ),
//     );
//   }
// }

enum Gender { male, female }
