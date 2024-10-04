import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFF extends StatelessWidget {
  TextEditingController controller;
  final String text;
  bool obsc;

  TextFF(
      {super.key, required this.controller, required this.text, required this.obsc});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey,
      child: TextFormField(
          controller: controller,
          obscureText: obsc,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: text,
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.transparent)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.transparent)
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty ) {
              return 'Please enter a valid $text';
            }
            return null;
          },
      ),
    );
  }
}
