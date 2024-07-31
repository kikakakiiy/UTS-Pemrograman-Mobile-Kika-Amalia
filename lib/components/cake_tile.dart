import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cake.dart';

class CakeTile extends StatelessWidget {
  final Cake cake;
  final void Function()? onTap;

  const CakeTile({
    super.key,
    required this.cake,
    this.onTap, // Changed required to optional for onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(
            left: 30, bottom: 25), // Margin bottom is retained
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Image.asset(
              cake.imagePath,
              height: 140,
              fit: BoxFit.cover, // Ensures the image fits within the bounds
            ),
            const SizedBox(height: 10), // Added space between image and text
            Text(
              cake.name,
              style: GoogleFonts.dmSerifDisplay(fontSize: 20),
            ),
            const SizedBox(
                height: 10), // Added space between name and price/rating
            // Price + rating
            SizedBox(
              width: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp ${cake.price.toStringAsFixed(0)}', // Ensure price is formatted correctly
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  // Rating icon
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[700], // Valid yellow color
                      ),
                      const SizedBox(width: 5), // Space between star and rating
                      Text(
                        cake.rating,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
