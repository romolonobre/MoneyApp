import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/balance_datasource.dart';
import 'data/datasources/transactions_datasource.dart';
import 'data/services/balance_service.dart';
import 'data/services/transactions_service.dart';
import 'interactor/balance_controller.dart';
import 'interactor/transaction_controller.dart';
import 'ui/payment/new_transaction_screen.dart';
import 'ui/payment/to_who_screen.dart';
import 'ui/transaction/transactions_screen.dart';

class TransactionsModule extends Module {
  @override
  void binds(i) {
    // Transactions
    i.addLazySingleton(TransactionsDatasource.new);
    i.addLazySingleton(TransactionsService.new);
    i.add(TransactionController.new);

    // Balance
    i.addLazySingleton(BalanceDatasource.new);
    i.addLazySingleton(BalanceService.new);
    i.add(BalanceController.new);
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => const TransactionsScreen());
    r.child("/amount", child: (context) => PaymentScreen(r.args.data));
    r.child("/to-who", child: (context) => ToWhoScreen(r.args.data));
  }
}
