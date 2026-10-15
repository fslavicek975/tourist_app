import '../model/sight_local.dart';

abstract interface class LocalSightRepository {
  Future<List<SightLocal>> getAllFavorites(String userUid);
  Future<void> toggleFavorite(SightLocal sight);
  Future<bool> isFavorite(int remoteId, String userUid);
  Future<void> updateRanking(SightLocal sight);
  Future<int?> getRanking(int remoteId, String userUid);
  Stream<void> watchSights();
}
