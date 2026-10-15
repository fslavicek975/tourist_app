import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/di.dart';
import 'package:tourist_app/domain/usecase/get_favorite_sights_use_case.dart';
import 'package:tourist_app/presentation/auth/notifier/state/authentication_state.dart' as auth;
import 'state/favorites_state.dart';

class FavoritesNotifier extends Notifier<FavoritesState> {
  late GetFavoriteSightsUseCase _getFavoriteSightsUseCase;

  @override
  FavoritesState build() {
    final authState = ref.watch(authenticationNotifierProvider);
    _getFavoriteSightsUseCase = ref.watch(getFavoriteSightsUseCaseProvider);
    
    final repository = ref.watch(localSightRepositoryProvider);
    final subscription = repository.watchSights().listen((_) => loadFavorites());
    ref.onDispose(() => subscription.cancel());

    if (authState is auth.AuthenticatedState) {
      loadFavorites();
      return LoadingState();
    } else {
      return EmptyState();
    }
  }

  void loadFavorites() async {
    final authState = ref.read(authenticationNotifierProvider);
    if (authState is auth.AuthenticatedState) {
      final sights = await _getFavoriteSightsUseCase(authState.currentUser.uid);
      state = sights.isEmpty ? EmptyState() : SuccessState(sights);
    }
  }
}
