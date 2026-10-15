import '../repository/user_repository.dart';

class UserSignOutUseCase {
  final UserRepository userRepository;

  UserSignOutUseCase(this.userRepository);

  Future<void> call() async {
    await userRepository.signOut();
  }
}
