import 'package:isar_community/isar.dart';

part 'sight_local.g.dart';

@collection
class SightLocal {
  Id id = Isar.autoIncrement;

  @Index()
  int? remoteId;
  String? userUid;

  String? title;
  String? description;
  String? imageUrl;
  double? lat;
  double? lng;

  bool isFavorite = false;
  int? ranking;
}