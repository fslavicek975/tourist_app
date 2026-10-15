import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/presentation/auth/notifier/authentication_notifier.dart';
import 'package:tourist_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:tourist_app/presentation/core/app_router.dart';
import 'package:tourist_app/presentation/core/style/extensions.dart';
import '../../../di.dart';
import '../../core/widget/custom_action_button.dart';
import '../widget/custom_text_field.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RegExp REG_EXP_EMAIL = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authenticationNotifierProvider);

    ref.listen(authenticationNotifierProvider, (_, currentState) {
      if (currentState is AuthenticatedState) {
        Navigator.of(context).pushReplacementNamed(AppRouter.mainMenuScreen);
      }

      if (currentState is ErrorState) {
        ErrorSnackBar.show(context, currentState.errorMessage);
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("assets/images/sign_in_image.png", height: 200),
                const SizedBox(height: 20),
                Text(
                  "Create a new account.",
                  style: context.textSubtitle,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  placeholder: "Email",
                  controller: _emailController,
                  validator: isEmailValid,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  placeholder: "Password",
                  controller: _passwordController,
                  validator: isPasswordValid,
                  isPasswordType: true,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  placeholder: "Confirm Password",
                  controller: _confirmPasswordController,
                  validator: isConfirmPasswordValid,
                  isPasswordType: true,
                ),
                const SizedBox(height: 30),
                CustomActionButton(
                  text: "Sign up",
                  isLoading: state is LoadingState,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authenticationNotifierProvider.notifier)
                          .signUp(
                            _emailController.text,
                            _passwordController.text,
                          );
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: context.textSubtitle,
                    ),
                    TextButton(
                      child: Text(
                        "Sign in",
                        style: context.textSubtitle.copyWith(
                          color: context.colorLink,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? isEmailValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    if (!REG_EXP_EMAIL.hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? isPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? isConfirmPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
