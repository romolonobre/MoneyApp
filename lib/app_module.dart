import 'package:flutter_modular/flutter_modular.dart';

import 'app/currency_converter/converter_module.dart';
import 'app/splash_screen.dart';
import 'app/transactions/transactions_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child("/splashscreen", child: (context) => const SplashScreen());
    r.module('/transactions', module: TransactionsModule());
    r.module('/converter', module: CurrencyConverterModule());
  }
}
