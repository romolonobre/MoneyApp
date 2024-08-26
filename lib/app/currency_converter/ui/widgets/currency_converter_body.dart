import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../_commons/amount_formatter.dart';
import '../../../_commons/custom_text.dart';
import '../../interactor/rate.dart';
import 'currency_converter_textformfield.dart';

class CurrencyConverterBody extends StatefulWidget {
  final List<Rate> rates;

  const CurrencyConverterBody({
    super.key,
    required this.rates,
  });

  @override
  State<CurrencyConverterBody> createState() => _CurrencyConverterBodyState();
}

class _CurrencyConverterBodyState extends State<CurrencyConverterBody> {
  final TextEditingController _amountController = TextEditingController(text: "£0");
  final TextEditingController _convertToController = TextEditingController();
  late Rate sellRate;
  late Rate buyRate;

  @override
  void initState() {
    super.initState();
    sellRate = widget.rates.firstWhere((element) => element.currency == "GBP");
    buyRate = widget.rates.firstWhere((element) => element.currency == "EUR");

    _amountController.addListener(updateConvertedValue);
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.removeListener(updateConvertedValue);
    _amountController.dispose();
    _convertToController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          "Sell GBP",
          color: Colors.black,
          fontSize: 22,
        ),
        CustomText(
          "£1 = ${buyRate.rate.toString()} ${buyRate.currency} ",
          color: Colors.blueAccent,
          fontSize: 14,
        ),
        const SizedBox(height: 20),
        CurrencyConverterTextFormfield(
          editingController: _amountController,
          rate: sellRate,
          isGBP: true,
        ),
        const SizedBox(height: 20),
        CurrencyConverterTextFormfield(
          editingController: _convertToController,
          rate: buyRate,
          ontap: () async {
            var rate = await _openBottomsheet();
            if (rate == null) return;
            buyRate = rate;
            setState(() {});
          },
        ),
      ],
    );
  }

  void updateConvertedValue() {
    double gbpValue = AmountFormatter.format(_amountController.text);
    double eurValue = gbpValue * buyRate.rate;
    _convertToController.text = NumberFormat.simpleCurrency(decimalDigits: 2, name: buyRate.currency).format(eurValue);
  }

  Future<Rate?> _openBottomsheet() async {
    Rate? newRate;

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 600,
          child: ListView.builder(
            itemCount: widget.rates.length,
            itemBuilder: (context, index) {
              final rate = widget.rates[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: CustomText(
                  rate.currency,
                  color: Colors.black,
                ),
                subtitle: CustomText(
                  rate.rate.toString(),
                  color: Colors.grey,
                ),
                onTap: () {
                  newRate = rate;
                  Modular.to.pop();
                },
              );
            },
          ),
        );
      },
    );
    return newRate;
  }
}
