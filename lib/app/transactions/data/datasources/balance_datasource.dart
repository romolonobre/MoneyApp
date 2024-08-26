import 'package:shared_preferences/shared_preferences.dart';

// Using SharedPreferences to simulate POST and GET endpoints for balance,
// allowing us to store and retrieve data locally as if interacting with a real API.

class BalanceDatasource {
  Future<double> getBalance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final double balance = prefs.getDouble("balance") ?? 0;
      return balance;
    } on Exception catch (e) {
      throw Exception('Failed to get balance: $e');
    }
  }

  Future<bool> updateBalance(double amount, bool isPayment) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      double balance = prefs.getDouble("balance") ?? 0;

      // Check if the balance is sufficient for payment
      if (isPayment && balance < amount) {
        return false;
      }

      // Calculate the new balance based on the operation type
      double updatedBalance = isPayment ? balance - amount : balance + amount;

      return await prefs.setDouble("balance", updatedBalance);
    } catch (e) {
      throw Exception('Failed to update balance: $e');
    }
  }
}
