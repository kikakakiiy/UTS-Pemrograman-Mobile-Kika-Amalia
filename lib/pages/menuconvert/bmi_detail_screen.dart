import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart'; // Ubah jika diperlukan
import 'package:url_launcher/url_launcher.dart'; // Add this package for launching URLs

class BMIDetailScreen extends StatelessWidget {
  final double bmi;
  final String category;

  BMIDetailScreen({required this.bmi, required this.category});

  @override
  Widget build(BuildContext context) {
    // Define color and info text based on BMI category
    Color colorStatus;
    String infoText;
    String imagePath;
    String? detailsUrl; // Make detailsUrl nullable

    switch (category) {
      case 'Underweight':
        colorStatus = Color(0xffFFB800); // Yellow
        infoText = "Berat rendah dapat menyebabkan :\n"
            "- Infertilitas\n"
            "- Anemia\n"
            "- Osteoporosis\n"
            "- Sistem Imun Lemah";
        imagePath = 'assets/images/images/1.png'; // Image for Underweight
        detailsUrl =
            'https://www.siloamhospitals.com/informasi-siloam/artikel/apa-itu-underweight'; // URL for Underweight
        break;
      case 'Normal weight':
        colorStatus = Color(0xff00CA39); // Green
        infoText = "Selamat, selalu jaga berat badan ideal anda.";
        imagePath = 'assets/images/images/2.png'; // Image for Normal weight
        detailsUrl = null; // No link for Normal weight
        break;
      case 'Overweight':
        colorStatus = Color(0xffFF5858); // Red
        infoText = "Beberapa penyakit dari kegemukan:\n"
            "- Diabetes\n"
            "- Hipertensi\n"
            "- Sakit Jantung\n"
            "- Osteoarthritis";
        imagePath = 'assets/images/images/3.png'; // Image for Overweight
        detailsUrl =
            'https://www.halodoc.com/kesehatan/obesitas'; // URL for Overweight
        break;
      case 'Obesity':
        colorStatus = Color(0xffFF0000); // Dark Red
        infoText = "Beberapa penyakit dari kegemukan:\n"
            "- Diabetes\n"
            "- Hipertensi\n"
            "- Sakit Jantung\n"
            "- Osteoarthritis";
        imagePath = 'assets/images/images/4.png'; // Image for Obesity
        detailsUrl =
            'https://www.halodoc.com/kesehatan/obesitas'; // URL for Obesity
        break;
      default:
        colorStatus = Colors.grey; // Default color
        infoText = "";
        imagePath = ''; // Default or placeholder image if needed
        detailsUrl = null; // No link for unknown categories
    }

    // Function to launch the URL
    _launchURL() async {
      if (detailsUrl != null) {
        // Check if detailsUrl is not null
        final url = detailsUrl;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Detail'),
        backgroundColor: Color.fromARGB(
            255, 252, 214, 132), // Set the AppBar color to orange
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your BMI is",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: colorStatus,
                ),
              ),
              SizedBox(height: 16), // Space between text and image
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imagePath.isNotEmpty
                      ? Container(
                          height: 220, // Adjust height as needed
                          width: 175, // Adjust width as needed
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit
                                .fitHeight, // Adjust fit to maintain height
                          ),
                        )
                      : Container(), // Empty container if no image
                  SizedBox(width: 16), // Space between image and indicator
                  Expanded(
                    child: Column(
                      children: [
                        Center(
                          child: CircularPercentIndicator(
                            radius: 100, // Adjust size
                            lineWidth: 20, // Adjust line width
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: bmi / 40, // Adjust the divisor as needed
                            center: Text(
                              "${bmi.toStringAsFixed(1)}",
                              style: TextStyle(
                                color: colorStatus,
                                fontSize: 50, // Adjust font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            footer: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0), // Reduced padding
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: colorStatus,
                                  fontSize: 24, // Adjust font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            progressColor: colorStatus,
                            backgroundColor: colorStatus.withOpacity(0.2),
                          ),
                        ),
                        SizedBox(
                            height: 16), // Space below CircularPercentIndicator
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16), // Space between indicator and info box
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 238, 212, 109), // Box color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    infoText,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center, // Center text within the box
                  ),
                ),
              ),
              SizedBox(height: 20), // Additional space at the bottom
              if (detailsUrl !=
                  null) // Conditionally display the "Get Details" box
                InkWell(
                  onTap: _launchURL,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 204, 132), // Box color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Get Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0), // Text color
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
