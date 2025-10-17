import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Button extends StatelessWidget {
  final String btnText;
  final Function() onPressed;
  final Color? bgColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  const Button({super.key, required this.btnText, required this.onPressed, this.bgColor, this.textColor, this.height, this.width, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 50,
      minWidth: width ?? double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: bgColor ?? Constants.primary,
      onPressed: onPressed,
      elevation: 0,
      child: Text(btnText, style: TextStyle(color: textColor ?? Colors.white, fontSize: fontSize ?? 16, fontWeight: FontWeight.w600)),
    );
  }
}

class OutlineButton extends StatelessWidget {
  final String btnText;
  final Function() onPressed;
  final Color? borderColor;
  final Color? textColor;
  final double? height;
  const OutlineButton({super.key, required this.btnText, required this.onPressed, this.borderColor, this.textColor, this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 50,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor ?? Constants.primary
        )
      ),
      color: Colors.transparent,
      onPressed: onPressed,
      elevation: 0,
      child: Text(btnText, style: TextStyle(color: textColor ?? Colors.white, fontSize: 16, fontWeight: FontWeight.w600))
    );
  }
}
