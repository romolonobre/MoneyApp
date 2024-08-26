import 'package:flutter/material.dart';

import '../data/services/balance_service.dart';
import 'states/balance_state.dart';

class BalanceController extends ValueNotifier<BalanceState> {
  final BalanceService service;
  BalanceController(this.service) : super(BalanceIndleState());

  Future<void> getBalance() async {
    _emit(BalanceLoadingState());
    final result = await service.getBalance();
    _emit(result);
  }

  Future<BalanceState> updateBalance({required double newBalance, bool isPayment = false}) async {
    final result = await service.updateBalance(newBalance, isPayment);
    return result;
  }

  void _emit(BalanceState state) => value = state;
}
