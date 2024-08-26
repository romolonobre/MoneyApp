import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../_commons/custom_text.dart';
import '../../../interactor/balance_controller.dart';
import '../../../interactor/states/balance_state.dart';

class BalanceWidget extends StatelessWidget {
  BalanceWidget({super.key});

  final controller = Modular.get<BalanceController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller..getBalance(),
      builder: (_, state, child) {
        return switch (state) {
          BalanceIndleState _ => const SizedBox.shrink(),
          BalanceUpdatedState _ => const SizedBox.shrink(),
          BalanceLoadingState _ => CustomText("Loading Balance...", fontSize: 15, color: Colors.grey[500]),
          BalanceLoadedState state => CustomText("£${state.balance.toStringAsFixed(2)}", fontSize: 40),
          BalanceErrorState() => CustomText(state.errorMessage, fontSize: 20, color: Colors.amber),
        };
      },
    );
  }
}
