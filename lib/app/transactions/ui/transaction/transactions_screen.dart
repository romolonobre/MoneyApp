import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_commons/custom_text.dart';
import '../../interactor/states/transactions_state.dart';
import '../../interactor/transaction_controller.dart';
import 'widgtes/balance_widget.dart';
import 'widgtes/custom_app_bar.dart';
import 'widgtes/transaction_action_bar.dart';
import 'widgtes/transactions_list_widget.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final controller = Modular.get<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: CustomAppBar(ontap: () => Modular.to.pushNamed('/converter')),
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          child: ValueListenableBuilder(
            valueListenable: controller..getTransactions(),
            builder: (_, state, child) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        color: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),

                        // Balance
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: BalanceWidget(),
                        ),
                      ),
                      switch (state) {
                        TransactionsIdleState _ => const SizedBox.shrink(),

                        // Loading state
                        TransactionsLoadingState _ => const SizedBox(
                            width: double.infinity,
                            child: Center(
                              heightFactor: 20,
                              child: CustomText(
                                "Loading transactions...",
                                color: Colors.pink,
                              ),
                            ),
                          ),

                        //  Loaded state
                        TransactionsLoadedState state => TransactionsListWidget(
                            transactions: state.transactions,
                          ),

                        //  Empty state
                        TransactionsEmptyState state => Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: CustomText(
                                  state.message,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),

                        // Erro state
                        TransactionsErrorState() => Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: CustomText(state.errorMessage, color: Colors.red),
                              ),
                            ),
                          )
                      }
                    ],
                  ),
                  // Pay and Top up buttons
                  const TransactionActionBar()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
