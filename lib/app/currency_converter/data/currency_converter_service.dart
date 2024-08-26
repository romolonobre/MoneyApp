// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../interactor/rate.dart';
import '../interactor/rate_state.dart';
import 'currency_converter_datasource.dart';

class CurrencyConverterService {
  CurrencyConverterDatasource datasource;
  CurrencyConverterService(this.datasource);

  Future<RateState> getAll() async {
    List<Rate> rates = [];
    try {
      final response = await datasource.getAll();

      for (var map in response.entries) {
        final Rate rate = Rate(currency: map.key, rate: map.value);
        rates.add(rate);
      }

      return RateLoadedState(rates: rates);
    } catch (e) {
      return RateErrorState(errorMessage: e.toString());
    }
  }
}
