import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';

class PasswordField extends StatefulWidget {
  final bool? autofocus;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final FormFieldValidator<String>? validation;
  const PasswordField({super.key, required this.hint, required this.controller, this.autofocus, this.keyboardType, this.maxLength, this.inputFormatters, this.onChanged, this.onSubmitted, this.validation});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      obscureText: isHide,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      style: TextStyle(color: Constants.primaryTextColor, fontSize: 16, fontWeight: FontWeight.w500),
      validator: widget.validation,
      decoration: InputDecoration(
        isDense: true,
          hintText: widget.hint,
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
          suffixIconConstraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isHide = !isHide;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                isHide ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey.shade500,
                size: 20,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
      ),
    );
  }
}
