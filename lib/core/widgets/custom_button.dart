// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';

// ignore: must_be_immutable
class AuthButton extends StatelessWidget {
  String buttonText;
  final VoidCallback onPressed;
  AuthButton({
    super.key,
    required this.buttonText, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [AppPallete.gradient1, AppPallete.gradient2])),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.transparentColor,
              shadowColor: AppPallete.transparentColor),
          child: Text(buttonText)),
    );
  }
}
