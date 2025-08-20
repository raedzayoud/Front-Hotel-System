import 'package:hotel/feature/home/data/repos/home_repo.dart';
import 'package:hotel/feature/home/presentation/manager/home_state.dart';

import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());

  Future<void> getAllHotels() async {
    emit(HomeLoading());
    try {
      final result = await homeRepo.getAllHotel();
      result.fold(
        (failure) => emit(HomeFailure(errorMessage: failure.errorMessage)),
        (hotels) => emit(HomeSuccess(hotels: hotels)),
      );
    } catch (e) {
      emit(HomeFailure(errorMessage: "An error occurred"));
    }
  }

  Future<void> searchHotels(String name) async {
    emit(SearchLoading());
    try {
      final result = await homeRepo.SearchHotel(name);
      result.fold(
        (failure) => emit(SearchFailure(errorMessage: failure.errorMessage)),
        (hotels) => emit(SearchSuccess(hotels: hotels)),
      );
    } catch (e) {
      emit(HomeFailure(errorMessage: "An error occurred"));
    }
  }

  Future<void> getProfile() async {
    emit(HomeLoading());
    try {
      final result = await homeRepo.getProfile();
      result.fold(
        (failure) => emit(HomeFailure(errorMessage: failure.errorMessage)),
        (hotels) => emit(HomeSuccess(hotels: [])),
      );
    } catch (e) {
      emit(HomeFailure(errorMessage: "An error occurred"));
    }
  }
}
