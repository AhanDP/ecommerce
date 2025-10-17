import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final bool? autofocus;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final FormFieldValidator<String>? validation;
  final bool? isReadOnly;
  final Icon? prefixIcon;

  const CustomTextField({super.key,
    required this.hint,
    required this.controller,
    this.autofocus,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.validation,
    this.isReadOnly,
    this.onTap, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus ?? false,
      readOnly: isReadOnly ?? false,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      style: TextStyle(color: Constants.primaryTextColor, fontSize: 16, fontWeight: FontWeight.w500),
      validator: validation,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
        counterText: "",
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Constants.textFieldBorderColor, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Constants.primary, width: 2),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      ),
    );
  }
}
