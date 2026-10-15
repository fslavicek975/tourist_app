import '../model/sight.dart';
import '../model/sight_local.dart';
import '../repository/local_sight_repository.dart';

class ToggleFavoriteUseCase {
  final LocalSightRepository localSightRepository;

  ToggleFavoriteUseCase(this.localSightRepository);

  Future<void> call(Sight sight, String userUid) async {
    final sightLocal = SightLocal();
    sightLocal.remoteId = sight.id;
    sightLocal.userUid = userUid;
    sightLocal.title = sight.title;
    sightLocal.description = sight.description;
    sightLocal.imageUrl = sight.imageUrl;
    sightLocal.lat = sight.lat;
    sightLocal.lng = sight.lng;
    
    await localSightRepository.toggleFavorite(sightLocal);
  }
}
