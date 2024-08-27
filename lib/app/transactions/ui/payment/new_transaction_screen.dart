// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:money_app/app/_commons/amount_formatter.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

import '../../../_commons/custom_snackbar.dart';
import '../../../_commons/custom_text.dart';
import '../../interactor/balance_controller.dart';
import '../../interactor/states/payment_state.dart';
import '../../interactor/transaction.dart';
import '../../interactor/transaction_controller.dart';
import '../transaction/widgtes/custom_app_bar.dart';
import 'widget/payment_action_button.dart';

class PaymentScreen extends StatefulWidget {
  final TRANSACTION_TYPE type;
  const PaymentScreen(this.type, {super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final controller = Modular.get<TransactionController>();
  final balanceController = Modular.get<BalanceController>();
  String text = '';
  bool hasError = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        ontap: () => Modular.to.pop(),
        icon: Icons.close,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CustomText(
              "How Much?",
              fontSize: 25,
            ),
            const SizedBox(height: 80),

            // Amount input
            CustomText(
              NumberFormat.simpleCurrency(
                decimalDigits: 0,
                locale: "en_GB",
              ).format(
                AmountFormatter.format(_amountController.text),
              ),
              fontSize: 40,
            ),
            const Spacer(),

            // keyboard
            VirtualKeyboard(
              type: VirtualKeyboardType.Numeric,
              textColor: Colors.white,
              textController: _amountController,
              fontSize: 25,
              height: 240,
              onKeyPress: _onKeyPress,
            ),
            const SizedBox(height: 80),

            // Top Up or Next button based on the Transaction type
            PaymentActionButton(
              label: widget.type == TRANSACTION_TYPE.topUp ? "Top Up" : "Next",
              onTap: () {
                handlePayment();
              },
            ),

            // Show an error message if the user attempts to proceed without entering an amount
            if (hasError) const CustomText("Please enter an amount", color: Colors.amber),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  handlePayment() async {
    if (isAmountEmpty()) return;

    if (widget.type == TRANSACTION_TYPE.topUp) {
      final result = await controller.pay(
        Transaction(
          type: widget.type,
          label: "Top Up",
          amount: double.tryParse(_amountController.text) ?? 0,
          date: DateTime.now(),
        ),
      );

      // Show error message
      if (result is PaymentErrorState) {
        if (!mounted) return;
        CustomSnackbar.show(context, message: result.errorMessage, isError: true);
        return;
      }

      handleBalanceUpdate();

      // Navigate to Transaction screen if payment is
      // successfull and show successfull top up snackbar
      Modular.to.pushNamedAndRemoveUntil('/transactions', (p0) => true);
      if (!mounted) return;
      CustomSnackbar.show(context, message: "Top-up completed successfully!");
      return;
    }

    // If the type is payment lest navigate to the to-who screen
    Modular.to.pushNamed('./to-who', arguments: double.tryParse(_amountController.text) ?? 0);
  }

  Future<void> handleBalanceUpdate() async {
    await balanceController.updateBalance(newBalance: double.tryParse(_amountController.text) ?? 0);
  }

  bool isAmountEmpty() {
    if (_amountController.text.isEmpty) {
      hasError = true;
      setState(() {});
      return true;
    }
    return false;
  }

  /// Fired when the virtual keyboard key is pressed
  _onKeyPress(VirtualKeyboardKey key) {
    setState(() {});
    if (key.keyType == VirtualKeyboardKeyType.String) {
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.isEmpty) return;
          text = text.substring(0, text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          text = '$text\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          text = text + (key.text ?? '');
          break;

        default:
      }
    }
  }
}
