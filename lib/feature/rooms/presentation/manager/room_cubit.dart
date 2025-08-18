import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:hotel/feature/rooms/data/repos/room_repo.dart';
import 'package:hotel/feature/rooms/presentation/manager/room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepo roomRepo;
  RoomCubit(this.roomRepo) : super(RoomInitial());

  Future<void> getAllRooms(String idHotel) async {
    emit(RoomLoading());
    try {
      final result = await roomRepo.getAllRooms(idHotel);
      result.fold(
        (failure) => emit(RoomFailure(errorMessage: failure.errorMessage)),
        (rooms) => emit(RoomSuccess(rooms: rooms)),
      );
    } catch (e) {
      emit(RoomFailure(errorMessage: "An error occurred"));
    }
  }

  Future<void> BookingRoom(String idRoom, int price) async {
    emit(RoomLoading());
    try {
      final result = await roomRepo.bookingRoom(idRoom, price);
      result.fold(
        (failure) => emit(RoomFailure(errorMessage: failure.errorMessage)),
        (rooms) => emit(RoomSuccess(rooms: [])),
      );
    } catch (e) {
      emit(RoomFailure(errorMessage: "An error occurred"));
    }
  }
}
