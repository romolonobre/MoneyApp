import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../_commons/custom_text.dart';
import '../../../interactor/transaction.dart';
import 'transaction_tile_widget.dart';

class TransactionsListWidget extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsListWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    Map<String, List<Transaction>> groupedTransactions = {};

    for (var transaction in transactions) {
      String formattedDate = formatDate(transaction.date);

      // If the date is not already a key in the map, add it with an empty list
      if (groupedTransactions[formattedDate] == null) {
        groupedTransactions[formattedDate] = [];
      }

      // Add the transaction to the list for this date
      groupedTransactions[formattedDate]!.add(transaction);
    }

    // Sort keys: "Today" first, "Yesterday" second, then other dates
    List<String> sortedKeys = groupedTransactions.keys.toList()
      ..sort((a, b) {
        if (a == "Today") return -1;
        if (b == "Today") return 1;
        if (a == "Yesterday") return -1;
        if (b == "Yesterday") return 1;
        return DateFormat.yMMMd().parse(a).compareTo(DateFormat.yMMMd().parse(b));
      });

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xfff7f7f7),
              child: ListView.builder(
                itemCount: groupedTransactions.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(
                        top: 60,
                        left: 20,
                      ),
                      child: CustomText(
                        "Recent Activity",
                        color: Colors.black,
                      ),
                    );
                  }

                  String dateKey = sortedKeys[index - 1];
                  List<Transaction> transactionsForDate = groupedTransactions[dateKey]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
                        child: CustomText(
                          dateKey,
                          color: Colors.grey,
                        ),
                      ),
                      ...transactionsForDate.reversed.map((transaction) {
                        return TransactionTileWidget(transaction: transaction);
                      }),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    if (DateFormat.yMd().format(date) == DateFormat.yMd().format(today)) {
      return 'Today';
    } else if (DateFormat.yMd().format(date) == DateFormat.yMd().format(yesterday)) {
      return 'Yesterday';
    } else {
      return DateFormat.yMMMd().format(date);
    }
  }
}
