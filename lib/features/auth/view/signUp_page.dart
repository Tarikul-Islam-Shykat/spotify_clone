// ignore_for_file: file_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/widgets/custom_button.dart';
import 'package:spotify_clone/core/widgets/custom_textForm.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';
import 'package:spotify_clone/core/constants/app_constant.dart';
import 'package:spotify_clone/core/widgets/loader.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/auth/model/sign_up_model.dart';
import 'package:spotify_clone/features/auth/view/signIn_page.dart';
import 'package:spotify_clone/features/auth/viewModel/auth_viewmodel.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final signUpForm = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TO WATCH THE CHANGES
    final isLoading = ref.watch(
        authViewModelProvider.select((value) => value?.isLoading == true));
    // UPDATING THE CHANGES.
    ref.listen(authViewModelProvider, (previous, next) {
      next?.when(
          data: (data) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                  content: Text("Account Created Successfully")));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInPage()));
          },
          error: (error, stackRace) {
            showCustomSnackbar(context, "Failed. $error");
          },
          loading: () {});
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.transparentColor,
      ),
      body: isLoading
          ? const Center(child: Loader())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: signUpForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Sign Up.",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    needHeight(10),
                    AuthField(
                        hintText: "Name",
                        textEditingController: nameController),
                    needHeight(10),
                    AuthField(
                        hintText: "Email",
                        textEditingController: emailController),
                    needHeight(10),
                    AuthField(
                      hintText: "Password",
                      textEditingController: passwordController,
                      isObscureText: true,
                    ),
                    needHeight(10),
                    AuthButton(
                      onPressed: () async {
                        if (signUpForm.currentState!.validate()) {
                          var userInfo = UserSignUpModel(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text);

                          ref.read(authViewModelProvider.notifier).signUpUser(
                              name: userInfo.name!,
                              email: userInfo.email!,
                              password: userInfo.password!);
                        }
                      },
                      buttonText: "Sign Up",
                    ),
                    needHeight(10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()));
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "Already Have an Acount ? ",
                              children: [
                            TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                    color: AppPallete.gradient2,
                                    fontSize: AppConstants.size2Text(context)))
                          ])),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget needHeight(double value) {
    return SizedBox(
      height: value,
    );
  }
}
