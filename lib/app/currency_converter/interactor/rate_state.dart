import 'rate.dart';

sealed class RateState {}

class RateIdleState extends RateState {}

class RateLoadingState extends RateState {}

class RateLoadedState extends RateState {
  final List<Rate> rates;

  RateLoadedState({required this.rates});
}

class RateErrorState extends RateState {
  final String errorMessage;

  RateErrorState({required this.errorMessage});
}
