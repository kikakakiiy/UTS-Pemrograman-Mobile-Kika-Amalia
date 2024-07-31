import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _isPressed
              ? Color.fromARGB(255, 103, 91, 116) // ubah warna button saat klik
              : Color.fromARGB(255, 153, 124, 160),
          borderRadius: BorderRadius.circular(45),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_forward,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
      ),
    );
  }
}
