import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:money_app/app/_commons/custom_text.dart';

import '../interactor/currency_converter_controller.dart';
import '../interactor/rate_state.dart';
import 'widgets/currency_converter_body.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final controller = Modular.get<CurrencyConverterController>();

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
          return switch (state) {
            RateIdleState _ => const SizedBox.shrink(),
            RateLoadingState _ => const Center(child: CircularProgressIndicator()),
            RateErrorState state => Center(child: CustomText(state.errorMessage, color: Colors.red)),
            RateLoadedState state => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CurrencyConverterBody(rates: state.rates),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
