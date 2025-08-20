import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:hotel/feature/booking/data/repo/booking_repo.dart';
import 'package:meta/meta.dart';

part 'booking_state.dart';

class bookingCubit extends Cubit<bookingState> {
  final BookingRepo bookingRepo;
  bookingCubit(this.bookingRepo) : super(bookingInitial());

  Future<void> getAllRoomsByUser() async {
    emit(bookingLoading());
    try {
      final result = await bookingRepo.getIncomingPastRooms();
      result.fold(
        (failure) => emit(bookingFailure(errorMessage: failure.errorMessage)),
        (list) => emit(bookingSuccess(list: list)),
      );
    } catch (e) {
      emit(bookingFailure(errorMessage: "An error occurred"));
    }
  }
}
