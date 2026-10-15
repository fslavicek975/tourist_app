import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/domain/model/sight_local.dart';
import 'package:tourist_app/presentation/auth/notifier/state/authentication_state.dart' as auth;
import 'package:tourist_app/presentation/sights/notifier/state/sight_details_state.dart';

import '../../../di.dart';
import '../../../domain/repository/local_sight_repository.dart';
import '../../../domain/usecase/toggle_favorite_use_case.dart';

class SightDetailsNotifier extends Notifier<SightDetailsState> {
  late LocalSightRepository _repository;
  late ToggleFavoriteUseCase _toggleUseCase;

  @override
  SightDetailsState build() {
    // 1. Watch the selected sight and the user
    final sight = ref.watch(selectedSightProvider);
    final authState = ref.watch(authenticationNotifierProvider);

    _repository = ref.watch(localSightRepositoryProvider);
    _toggleUseCase = ref.watch(toggleFavoriteUseCaseProvider);

    // 2. If nothing is selected or no user, we can't show details
    if (sight == null || authState is! auth.AuthenticatedState) {
      return LoadingState();
    }

    // 3. Setup database watcher
    final subscription = _repository.watchSights().listen((_) => loadDetails());
    ref.onDispose(() => subscription.cancel());

    loadDetails();
    return LoadingState();
  }

  void loadDetails() async {
    final sight = ref.read(selectedSightProvider);
    final authState = ref.read(authenticationNotifierProvider);

    if (sight != null && authState is auth.AuthenticatedState) {
      final isFav = await _repository.isFavorite(sight.id, authState.currentUser.uid);
      final rank = await _repository.getRanking(sight.id, authState.currentUser.uid);
      state = SuccessState(isFav, rank);
    }
  }

  void toggleFavorite() async {
    final sight = ref.read(selectedSightProvider);
    final authState = ref.read(authenticationNotifierProvider);

    if (sight != null && authState is auth.AuthenticatedState) {
      await _toggleUseCase(sight, authState.currentUser.uid);
    }
  }

  void updateRanking(int ranking) async {
    final sight = ref.read(selectedSightProvider);
    final authState = ref.read(authenticationNotifierProvider);

    if (sight != null && authState is auth.AuthenticatedState) {
      final sightLocal = SightLocal()
        ..remoteId = sight.id
        ..userUid = authState.currentUser.uid
        ..title = sight.title
        ..description = sight.description
        ..imageUrl = sight.imageUrl
        ..lat = sight.lat
        ..lng = sight.lng
        ..ranking = ranking;

      await _repository.updateRanking(sightLocal);
    }
  }
}
