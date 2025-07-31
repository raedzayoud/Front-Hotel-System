sealed class RoomState {}

final class RoomInitial extends RoomState {}

final class RoomFailure extends RoomState {
  final String errorMessage;
  RoomFailure({required this.errorMessage});
}

final class RoomLoading extends RoomState {}

final class RoomSuccess extends RoomState {
  final List rooms;
  RoomSuccess({required this.rooms});
}
