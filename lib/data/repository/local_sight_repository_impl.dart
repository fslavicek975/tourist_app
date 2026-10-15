import 'package:isar_community/isar.dart';
import '../../domain/model/sight_local.dart';
import '../../domain/repository/local_sight_repository.dart';

class LocalSightRepositoryImpl implements LocalSightRepository {
  final Isar isar;

  LocalSightRepositoryImpl(this.isar);

  @override
  Future<List<SightLocal>> getAllFavorites(String userUid) async {
    return await isar.sightLocals
        .filter()
        .userUidEqualTo(userUid)
        .isFavoriteEqualTo(true)
        .findAll();
  }

  @override
  Future<void> toggleFavorite(SightLocal sight) async {
    await isar.writeTxn(() async {
      final existing = await isar.sightLocals
          .filter()
          .remoteIdEqualTo(sight.remoteId)
          .and()
          .userUidEqualTo(sight.userUid)
          .findFirst();

      if (existing != null) {
        existing.isFavorite = !existing.isFavorite;
        await isar.sightLocals.put(existing);
      } else {
        sight.isFavorite = true;
        await isar.sightLocals.put(sight);
      }
    });
  }

  @override
  Future<bool> isFavorite(int remoteId, String userUid) async {
    final sight = await isar.sightLocals
        .filter()
        .remoteIdEqualTo(remoteId)
        .and()
        .userUidEqualTo(userUid)
        .findFirst();
    return sight?.isFavorite ?? false;
  }

  @override
  Future<void> updateRanking(SightLocal sight) async {
    await isar.writeTxn(() async {
      final existing = await isar.sightLocals
          .filter()
          .remoteIdEqualTo(sight.remoteId)
          .and()
          .userUidEqualTo(sight.userUid)
          .findFirst();

      if (existing != null) {
        existing.ranking = sight.ranking;
        await isar.sightLocals.put(existing);
      } else {
        await isar.sightLocals.put(sight);
      }
    });
  }

  @override
  Future<int?> getRanking(int remoteId, String userUid) async {
    final sight = await isar.sightLocals
        .filter()
        .remoteIdEqualTo(remoteId)
        .and()
        .userUidEqualTo(userUid)
        .findFirst();
    return sight?.ranking;
  }

  @override
  Stream<void> watchSights() {
    return isar.sightLocals.watchLazy();
  }
}
