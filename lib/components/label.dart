import 'package:flutter/material.dart';
import '../utills/constants.dart';

class Label extends StatelessWidget {
  final String text;
  const Label({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: TextStyle(color: Constants.primaryTextColor, fontSize: 16, fontWeight: FontWeight.w600)),
        Text(" *", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
