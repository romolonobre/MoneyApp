import 'package:flutter/material.dart';
import 'package:money_app/app/_commons/mui_text.dart';
import 'package:money_app/app/currency_converter/interactor/currency_converter_controller.dart';
import 'package:money_app/app/currency_converter/interactor/rate_state.dart';
import 'package:money_app/app/currency_converter/ui/converter_textform_field.dart';

import '../interactor/rate.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final controller = CurrencyConverterController();
  Rate rate = Rate(currency: '', rate: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f7f7),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller..getAll(),
        builder: (_, state, child) {
          if (state is RateErrorState) {
            return Center(
              child: CustomText(
                state.errorMessage,
                color: Colors.red,
              ),
            );
          }
          if (state is RateLoadedState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  ConverterTextformField(
                    currency: rate.currency.toString(),
                    rates: state.rates,
                    onTap: () {},
                    isAmout: true,
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
