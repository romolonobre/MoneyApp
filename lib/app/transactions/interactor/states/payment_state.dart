abstract class PaymentState {}

class PaymentErrorState extends PaymentState {
  final String errorMessage;

  PaymentErrorState({required this.errorMessage});
}

class PaymentSuccessState extends PaymentState {
  final String message;
  PaymentSuccessState({required this.message});
}
