import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:hotel/feature/authentication/data/model/user.dart';
import 'package:hotel/feature/authentication/data/repos/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepo authenticationRepo;
  AuthenticationCubit(this.authenticationRepo) : super(AuthenticationInitial());
  Future<void> signIn(User user) async {
    emit(AuthenticationLoading());
    try {
      final result = await authenticationRepo.signIn(user);
      result.fold(
        (failure) =>
            emit(AuthenticationFailure(errorMessage: failure.errorMessage)),
        (success) => emit(AuthenticationSuccess()),
      );
    } catch (e) {
      emit(AuthenticationFailure(errorMessage: "An error occurred"));
    }
  }

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final result = await authenticationRepo.login(username, password);
      result.fold(
        (failure) => emit(LoginFailure(errorMessage: failure.errorMessage)),
        (token) => emit(LoginSuccess(token: token)),
      );
    } catch (e) {
      emit(AuthenticationFailure(errorMessage: "An error occurred"));
    }
  }

  Future<Map<String, dynamic>?> getUserDetails(String token) async {
    try {
      final result = await authenticationRepo.getUserDetails(token);
      return result.fold(
        (failure) {
          emit(AuthenticationFailure(errorMessage: failure.errorMessage));
          return null;
        },
        (userData) => userData, // Map<String, dynamic>
      );
    } catch (e) {
      emit(AuthenticationFailure(errorMessage: "An error occurred"));
      return null;
    }
  }
}
