import '../model/result.dart';
import '../model/sight.dart';

abstract interface class SightRepository {
  Future<Result<List<Sight>>> getAllSights();
}