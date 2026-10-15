sealed class SightDetailsState {}

class LoadingState extends SightDetailsState {}

class SuccessState extends SightDetailsState {
  final bool isFavorite;
  final int? ranking;

  SuccessState(this.isFavorite, this.ranking);
}

class ErrorState extends SightDetailsState {
  final String message;
  ErrorState(this.message);
}
