// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../_commons/custom_text.dart';

class TransactionActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String args;

  const TransactionActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => Modular.to.pushNamed("./amount", arguments: args),
          icon: Icon(
            icon,
            size: 30,
          ),
          color: Theme.of(context).iconTheme.color,
        ),
        CustomText(
          label,
          color: Colors.black,
        ),
      ],
    );
  }
}
