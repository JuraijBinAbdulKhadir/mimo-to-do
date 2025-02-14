
import 'package:flutter/material.dart';

class TextBut extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const TextBut({super.key,required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,

        child: Text(text,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),));
  }
}
