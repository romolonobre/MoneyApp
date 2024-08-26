import 'package:flutter/material.dart';

import '../../../../_commons/custom_text.dart';
import '../../../interactor/transaction.dart';

class TransactionTileWidget extends StatelessWidget {
  final Transaction transaction;
  const TransactionTileWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    bool isTopUp = transaction.type == "topUp";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),

              // Icon
              child: Icon(
                isTopUp ? Icons.add : Icons.shopping_bag,
                color: Colors.white,
              ),
            ),

            // Transaction label
            title: CustomText(
              transaction.label,
              color: Colors.black,
            ),

            // Transaction amount
            trailing: CustomText(
              isTopUp ? "+£${transaction.amount.toStringAsFixed(2)}" : "-£${transaction.amount.toStringAsFixed(2)}",
              color: isTopUp ? Theme.of(context).primaryColor : Colors.black87,
              fontSize: isTopUp ? 23 : 18,
            ),
          ),
        )
      ],
    );
  }
}
