sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure({required this.errorMessage});
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List hotels;
  HomeSuccess({required this.hotels});
}

// Search Hotels

final class SearchFailure extends HomeState {
  final String errorMessage;
  SearchFailure({required this.errorMessage});
}

final class SearchLoading extends HomeState {}

final class SearchSuccess extends HomeState {
  final List hotels;
  SearchSuccess({required this.hotels});
}
