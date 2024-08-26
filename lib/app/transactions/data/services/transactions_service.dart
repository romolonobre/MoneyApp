import '../../interactor/states/payment_state.dart';
import '../../interactor/states/transactions_state.dart';
import '../../interactor/transaction.dart';
import '../datasources/transactions_datasource.dart';

class TransactionsService {
  final TransactionsDatasource datasource;

  TransactionsService(this.datasource);

  Future<TransactionsState> getTransactions() async {
    try {
      final response = await datasource.getTransactions();

      if (response.isEmpty) {
        return TransactionsEmptyState(message: "No Transactions available");
      }

      var newList = response as List<dynamic>;
      final transactions = <Transaction>[];

      for (var rowData in newList) {
        final transaction = Transaction.fromJson(rowData);
        transactions.add(transaction);
      }

      return TransactionsLoadedState(transactions: transactions);
    } catch (e) {
      return TransactionsErrorState(errorMessage: e.toString());
    }
  }

  Future<PaymentState> pay(Transaction transaction) async {
    try {
      final success = await datasource.pay(transaction);

      if (!success) {
        return PaymentErrorState(errorMessage: "Payment could not be processed. Please try again.");
      }

      return PaymentSuccessState(message: "Thank you! Your payment has been processed successfully.");
    } catch (e) {
      return PaymentErrorState(errorMessage: e.toString());
    }
  }
}
