// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../_commons/amount_formatter.dart';
import '../../../_commons/custom_text.dart';
import '../../interactor/rate.dart';

class CurrencyConverterTextFormfield extends StatelessWidget {
  final Rate rate;
  final TextEditingController editingController;
  final Function? ontap;
  bool isGBP;

  CurrencyConverterTextFormfield({
    super.key,
    required this.rate,
    required this.editingController,
    this.ontap,
    this.isGBP = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      autofocus: true,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(30),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.grey.shade300,
        prefixIcon: isGBP
            ? Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: CustomText(
                  rate.currency,
                  color: Colors.black,
                  fontSize: 18,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    // Currency picker
                    InkWell(
                      onTap: () async {
                        ontap != null ? ontap!() : null;
                      },
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              rate.currency,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                      ),
                    ),

                    // Currency rate
                    CustomText(
                      rate.rate.toString(),
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
      ),
      inputFormatters: [
        CurrencyInputFormatter(rate.currency),
      ],
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final String currency;
  CurrencyInputFormatter(this.currency);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedValue = NumberFormat.simpleCurrency(decimalDigits: 0, name: currency).format(
      AmountFormatter.format(newValue.text),
    );

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
