part of 'booking_cubit.dart';

@immutable
sealed class bookingState {}

final class bookingInitial extends bookingState {}

final class bookingLoading extends bookingState {}

final class bookingFailure extends bookingState {
  final String errorMessage;
  bookingFailure({required this.errorMessage});
}

final class bookingSuccess extends bookingState {
  final List<Map<String, dynamic>> list;
  bookingSuccess({required this.list});
}
