import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField(
      {super.key, this.validator, required this.controller, required this.hintText,
        required this.prefixIcon, this.suffixIcon, this.obscureText = false});

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  InputBorder borderBuilder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
          color: AppColors.lightGrey
      )
  );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: borderBuilder(),
        focusedBorder: borderBuilder(),
        enabledBorder: borderBuilder(),

      ),

    );
  }
}