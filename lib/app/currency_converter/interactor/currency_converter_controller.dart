import 'package:flutter/foundation.dart';

import '../data/currency_converter_service.dart';
import 'rate_state.dart';

class CurrencyConverterController extends ValueNotifier<RateState> {
  final CurrencyConverterService service;
  CurrencyConverterController(this.service) : super(RateIdleState());

  Future<void> getAll() async {
    _emit(RateLoadingState());
    final result = await service.getAll();
    _emit(result);
  }

  void _emit(RateState state) => value = state;
}
