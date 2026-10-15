import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tourist_app/presentation/core/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    redirectToTheNextScreen(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/camping_image.png"),
              Lottie.asset("assets/animations/loading_dots.json", width: 150),
            ],
          ),
        ),
      ),
    );
  }

  void redirectToTheNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (isUserSignedIn()) {
      Navigator.of(context).pushReplacementNamed(AppRouter.mainMenuScreen);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRouter.signInScreen);
    }
  }

  bool isUserSignedIn() => FirebaseAuth.instance.currentUser != null;
}
