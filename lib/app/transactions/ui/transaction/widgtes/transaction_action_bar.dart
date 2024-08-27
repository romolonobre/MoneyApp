import 'package:flutter/material.dart';

import '../../../interactor/transaction.dart';
import 'transaction_action_button.dart';

class TransactionActionBar extends StatelessWidget {
  const TransactionActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 130,
      left: 16,
      right: 16,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //
            // New Payment button
            TransactionActionButton(
              label: "Pay",
              icon: Icons.payment,
              args: TRANSACTION_TYPE.payment,
            ),

            // Top Up button
            TransactionActionButton(
              label: "Top Up",
              icon: Icons.add,
              args: TRANSACTION_TYPE.topUp,
            ),
          ],
        ),
      ),
    );
  }
}
