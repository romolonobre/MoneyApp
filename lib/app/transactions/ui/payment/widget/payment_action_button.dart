import 'package:flutter/material.dart';

import '../../../../_commons/custom_text.dart';

class PaymentActionButton extends StatelessWidget {
  final Function? onTap;
  final String label;
  const PaymentActionButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        width: 230,
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xffdc7dc1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CustomText(label),
        ),
      ),
    );
  }
}
