// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../transaction.dart';

sealed class TransactionsState {}

class TransactionsIdleState extends TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsLoadedState extends TransactionsState {
  final List<Transaction> transactions;
  TransactionsLoadedState({required this.transactions});
}

class TransactionsEmptyState extends TransactionsState {
  final String message;
  TransactionsEmptyState({required this.message});
}

class TransactionsErrorState extends TransactionsState {
  final String errorMessage;

  TransactionsErrorState({required this.errorMessage});
}
