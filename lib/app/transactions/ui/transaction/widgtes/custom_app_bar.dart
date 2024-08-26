import 'package:flutter/material.dart';

import '../../../../_commons/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData? icon;
  final VoidCallback ontap;

  const CustomAppBar({super.key, this.icon, required this.ontap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: const SizedBox.shrink(),
      title: const CustomText(
        "MoneyApp",
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
          onPressed: ontap,
          icon: Icon(
            icon ?? Icons.currency_exchange,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
