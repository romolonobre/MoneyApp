sealed class BalanceState {}

class BalanceIndleState extends BalanceState {}

class BalanceLoadingState extends BalanceState {}

class BalanceLoadedState extends BalanceState {
  final double balance;

  BalanceLoadedState({required this.balance});
}

class BalanceErrorState extends BalanceState {
  final String errorMessage;

  BalanceErrorState({required this.errorMessage});
}

class BalanceUpdatedState extends BalanceState {}
