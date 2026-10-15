import 'package:tourist_app/data/client/sight_rest_client.dart';
import 'package:tourist_app/domain/model/sight.dart';
import 'package:tourist_app/domain/repository/sight_repository.dart';

import '../../domain/model/result.dart';

class SightRepositoryImpl implements SightRepository {

  final SightRestClient _restClient;

  SightRepositoryImpl(this._restClient);

  @override
  Future<Result<List<Sight>>> getAllSights() async {
    try{
      final list = await _restClient.getAllSights();
      return  Result.ok(list);
    } catch (e){
      return Result.error(Exception("Failed to fetch sights."));
    }
  }

}