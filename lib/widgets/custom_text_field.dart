import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomInput({
    super.key,
    required this.controller,
    required this.hint,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: kWhite,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kInputRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
