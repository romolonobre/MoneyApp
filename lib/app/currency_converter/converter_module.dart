import 'package:flutter_modular/flutter_modular.dart';

import 'data/currency_converter_datasource.dart';
import 'data/currency_converter_service.dart';
import 'interactor/currency_converter_controller.dart';
import 'ui/currency_converter_screen.dart';

class CurrencyConverterModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(CurrencyConverterDatasource.new);
    i.addLazySingleton(CurrencyConverterService.new);
    i.add(CurrencyConverterController.new);
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => const CurrencyConverterScreen());
  }
}
