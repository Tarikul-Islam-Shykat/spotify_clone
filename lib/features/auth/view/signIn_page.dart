// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart ' hide State;
import 'package:spotify_clone/core/widgets/custom_button.dart';
import 'package:spotify_clone/core/widgets/custom_textForm.dart';
import 'package:spotify_clone/core/colors/app_pallete.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/auth/model/sign_up_model.dart';
import 'package:spotify_clone/features/auth/repo/auth_remote_repo.dart';
import 'package:spotify_clone/features/auth/view/signUp_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/features/auth/viewModel/auth_viewmodel.dart';
import 'package:spotify_clone/features/home/view/home_page.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        authViewModelProvider.select((value) => value?.isLoading == true));
    ref.listen(authViewModelProvider, (previous, next) {
      next?.when(
          data: (data) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()), (_) => false);
          },
          error: (error, stackRace) {
            log("error $error");
            //showCustomSnackbar(context, "Failed. $error");
          },
          loading: () {});
    });
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Center(
                                child: Text(
                                  "Sign In.",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              needHeight(20),
                              AuthField(
                                hintText: "Enter your Email",
                                textEditingController: emailController,
                              ),
                              needHeight(10),
                              AuthField(
                                hintText: "Enter your Password",
                                textEditingController: passwordController,
                                isObscureText: true,
                              ),
                              needHeight(10),
                              AuthButton(
                                onPressed: () async {
                                  // var loginUserModel = UserSignUpModel(
                                  //     email: emailController.text.toString(),
                                  //     password:
                                  //         passwordController.text.toString());
                                  ref
                                      .read(authViewModelProvider.notifier)
                                      .loginUser(
                                          email:
                                              emailController.text.toString(),
                                          password: passwordController.text
                                              .toString());
                                  // var loginUserModel = UserSignUpModel(
                                  //     email: emailController.text.toString(),
                                  //     password:
                                  //         passwordController.text.toString());
                                  // final res = await AuthRemoteRepo()
                                  //     .exectueLogin(user: loginUserModel);

                                  // final val = switch (res) {
                                  //   Left(value: final l) =>
                                  //     l, // this l is a appfailure l
                                  //   Right(value: final r) => r
                                  // };

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const HomePage()));
                                  // log("$val");
                                },
                                buttonText: "Sign In",
                              ),
                              needHeight(15),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Don\'t have an account ? ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      children: const [
                                        TextSpan(
                                          text: "Sign Up",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppPallete.gradient2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget needHeight(double value) {
    return SizedBox(
      height: value,
    );
  }
}
