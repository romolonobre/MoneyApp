import 'package:flutter/material.dart';

import '../data/services/transactions_service.dart';
import 'states/payment_state.dart';
import 'states/transactions_state.dart';
import 'transaction.dart';

class TransactionController extends ValueNotifier<TransactionsState> {
  final TransactionsService service;
  TransactionController(this.service) : super(TransactionsIdleState());

  void _emit(TransactionsState state) => value = state;

  Future<void> getTransactions() async {
    _emit(TransactionsLoadingState());
    await Future.delayed(const Duration(milliseconds: 400));
    final result = await service.getTransactions();
    _emit(result);
  }

  Future<PaymentState> pay(Transaction transaction) async {
    final result = await service.pay(transaction);
    return result;
  }
}
