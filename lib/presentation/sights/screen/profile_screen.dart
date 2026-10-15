import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/presentation/auth/notifier/authentication_notifier.dart';
import 'package:tourist_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:tourist_app/presentation/core/app_router.dart';
import 'package:tourist_app/presentation/core/style/extensions.dart';

import '../../../di.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationNotifierProvider);

    ref.listen(authenticationNotifierProvider, (_, state) {
      if (state is EmptyState) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.signInScreen,
          (route) => false,
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile', style: context.textTitle),
              const SizedBox(height: 40),
              if (authState is AuthenticatedState) ...[
                const Text("Logged in as:", style: TextStyle(color: Colors.grey)),
                Text(
                  authState.currentUser.email ?? "No email",
                  style: context.textSubtitle,
                ),
              ],
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorError,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  ref.read(authenticationNotifierProvider.notifier).signOut();
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
