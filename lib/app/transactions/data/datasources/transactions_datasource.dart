import 'dart:convert';

import 'package:money_app/app/transactions/interactor/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Using SharedPreferences to simulate POST and GET endpoints for transactions,
// allowing us to store and retrieve data locally as if interacting with a real API.

class TransactionsDatasource {
  Future getTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      dynamic transactions = prefs.get("transactions");
      if (transactions == null) {
        return [];
      }

      return jsonDecode(transactions);
    } catch (e) {
      throw Exception('Failed to get Transactions: $e');
    }
  }

  Future<bool> pay(Transaction transaction) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? jsonString = prefs.getString("transactions");

      final List<dynamic> transactionsList = jsonString != null ? jsonDecode(jsonString) as List<dynamic> : [];

      transactionsList.add(transaction.toJson());

      bool result = await prefs.setString("transactions", jsonEncode(transactionsList));

      return result;
    } catch (e) {
      throw Exception('Failed to complete ${transaction.type}: $e');
    }
  }
}
