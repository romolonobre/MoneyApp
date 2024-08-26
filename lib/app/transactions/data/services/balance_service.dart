import '../../interactor/states/balance_state.dart';
import '../datasources/balance_datasource.dart';

class BalanceService {
  final BalanceDatasource datasource;

  BalanceService(this.datasource);

  Future<BalanceState> getBalance() async {
    try {
      final response = await datasource.getBalance();
      return BalanceLoadedState(balance: response);
    } catch (e) {
      return BalanceErrorState(errorMessage: e.toString());
    }
  }

  Future<BalanceState> updateBalance(double newBalance, bool isPayment) async {
    try {
      final updated = await datasource.updateBalance(newBalance, isPayment);
      if (!updated) {
        return BalanceErrorState(errorMessage: "Insufficient funds to complete this transaction.");
      }

      return BalanceUpdatedState();
    } catch (e) {
      return BalanceErrorState(errorMessage: e.toString());
    }
  }
}
