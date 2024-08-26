// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:money_app/app/transactions/interactor/states/balance_state.dart';

import '../../../_commons/custom_snackbar.dart';
import '../../../_commons/custom_text.dart';
import '../../interactor/balance_controller.dart';
import '../../interactor/states/payment_state.dart';
import '../../interactor/transaction.dart';
import '../../interactor/transaction_controller.dart';
import '../transaction/widgtes/custom_app_bar.dart';
import 'widget/payment_action_button.dart';

class ToWhoScreen extends StatefulWidget {
  final double amount;
  const ToWhoScreen(
    this.amount, {
    super.key,
  });

  @override
  State<ToWhoScreen> createState() => _ToWhoScreenState();
}

class _ToWhoScreenState extends State<ToWhoScreen> {
  String name = '';
  final controller = Modular.get<TransactionController>();
  final balanceController = Modular.get<BalanceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        icon: Icons.close,
        ontap: () => Modular.to.pop(),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 100),

              // Title header
              const CustomText(
                "To who?",
                fontSize: 25,
              ),
              const SizedBox(height: 40),

              // Input name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  onChanged: (value) => setState(() => name = value),
                ),
              ),
              const SizedBox(height: 40),

              // Pay button
              PaymentActionButton(
                onTap: () => onPay(),
                label: "Pay",
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  onPay() async {
    final result = await controller.pay(
      Transaction(
        type: "payment",
        label: name,
        amount: widget.amount,
        date: DateTime.now(),
      ),
    );
    if (result is PaymentErrorState) {
      return;
    }

    final balanceState = await balanceController.updateBalance(
      newBalance: widget.amount,
      isPayment: true,
    );
    if (balanceState is BalanceErrorState) {
      if (!mounted) return;
      CustomSnackbar.show(context, message: balanceState.errorMessage, isError: true);
      return;
    }

    Modular.to.pushNamedAndRemoveUntil('/transactions', (p0) => true);
  }
}
