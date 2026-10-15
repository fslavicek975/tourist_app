import '../../../../domain/model/sight_local.dart';

sealed class FavoritesState {}

class LoadingState extends FavoritesState {}

class SuccessState extends FavoritesState {
  final List<SightLocal> sights;

  SuccessState(this.sights);
}

class EmptyState extends FavoritesState {}

class ErrorState extends FavoritesState {
  final String message;

  ErrorState(this.message);
}
