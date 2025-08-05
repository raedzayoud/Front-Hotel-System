import 'package:hotel/feature/home/data/repos/home_repo.dart';
import 'package:hotel/feature/home/presentation/manager/home_state.dart';

import 'dart:async';
import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:hotel/feature/wallet/data/repos/wallet_repo.dart';
import 'package:hotel/feature/wallet/presentation/manager/wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepo walletRepo;
  WalletCubit(this.walletRepo) : super(WalletInitial());

  Future<void> addAmount(int oldSolde) async {
    emit(WalletLoading());
    try {
      final result = await walletRepo.addSolde(oldSolde);
      result.fold(
        (failure) => emit(WalletFailure(errorMessage: failure.errorMessage)),
        (newSolde) => emit(WalletSuccess(solde: newSolde)),
      );
    } catch (e) {
      emit(WalletFailure(errorMessage: "An error occurred"));
    }
  }
}
