sealed class WalletState {}

final class WalletInitial extends WalletState {}

final class WalletFailure extends WalletState {
  final String errorMessage;
  WalletFailure({required this.errorMessage});
}

final class WalletLoading extends WalletState {}

final class WalletSuccess extends WalletState {
  final int solde;
  WalletSuccess({required this.solde});
}
