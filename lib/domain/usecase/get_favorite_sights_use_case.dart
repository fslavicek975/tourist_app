import '../model/sight_local.dart';
import '../repository/local_sight_repository.dart';

class GetFavoriteSightsUseCase {
  final LocalSightRepository localSightRepository;

  GetFavoriteSightsUseCase(this.localSightRepository);

  Future<List<SightLocal>> call(String userUid) async {
    return await localSightRepository.getAllFavorites(userUid);
  }
}
