import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  final bool isObscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.textEditingController,
      this.isObscureText = false,
      this.readOnly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      controller: textEditingController,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
