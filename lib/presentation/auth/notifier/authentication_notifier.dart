import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/di.dart';
import 'package:tourist_app/domain/usecase/user_sign_in_use_case.dart';
import 'package:tourist_app/domain/usecase/user_sign_up_use_case.dart';
import 'package:tourist_app/domain/usecase/user_sign_out_use_case.dart';
import 'package:tourist_app/presentation/auth/notifier/state/authentication_state.dart';
import '../../../domain/model/result.dart';

class AuthenticationNotifier extends Notifier<AuthenticationState> {
  late UserSignInUseCase _signInUseCase;
  late UserSignUpUseCase _signUpUseCase;
  late UserSignOutUseCase _signOutUseCase;

  @override
  build() {
    _signInUseCase = ref.watch(userSignInUseCaseProvider);
    _signUpUseCase = ref.watch(userSignUpUseCaseProvider);
    _signOutUseCase = ref.watch(userSignOutUseCaseProvider);

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return AuthenticatedState(currentUser);
    }

    return EmptyState();
  }

  void signIn(final String email, final String password) async {
    state = LoadingState();
    final result = await _signInUseCase(email, password);

    switch (result) {
      case Ok<User>():
        state = AuthenticatedState(result.value);
      case Error():
        state = ErrorState(result.error.toString());
    }
  }

  void signUp(final String email, final String password) async {
    state = LoadingState();
    final result = await _signUpUseCase(email, password);

    switch (result) {
      case Ok<User>():
        state = AuthenticatedState(result.value);
      case Error():
        state = ErrorState(result.error.toString());
    }
  }

  void signOut() async {
    await _signOutUseCase();
    state = EmptyState();
  }
}
