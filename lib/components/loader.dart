import 'package:flutter/material.dart';
import '../utills/constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
          color: Constants.primary,
        ),
      ),
    );
  }
}
