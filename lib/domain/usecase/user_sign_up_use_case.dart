import 'package:firebase_auth/firebase_auth.dart';
import '../model/result.dart';
import '../repository/user_repository.dart';

class UserSignUpUseCase {
  final UserRepository userRepository;

  UserSignUpUseCase(this.userRepository);

  Future<Result<User>> call(String email, String password) async {
    return await userRepository.signUp(email, password);
  }
}
