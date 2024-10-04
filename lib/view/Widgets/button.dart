import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double width;
  final double height;
  const MyButton({super.key,required this.text,required this.onPressed,required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff316FF6),
          foregroundColor: Colors.white,
          shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)),
          minimumSize:  Size(width, height),
        ),
        child: Text(text));
  }
}
