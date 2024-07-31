import 'package:flutter/material.dart';

void showToastUnderFavoriteIcon(BuildContext context, bool isFavorite) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 70, // Sesuaikan posisi ini dengan kebutuhan
      right: 20, // Sesuaikan posisi ini dengan kebutuhan
      child: Material(
        color: const Color.fromARGB(0, 119, 96, 96),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 96, 85, 85).withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isFavorite ? "Added to Favorites" : "Removed from Favorites",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
