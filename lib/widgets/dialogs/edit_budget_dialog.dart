import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../objects/budget.dart';
import '../../globals.dart';

import '../../providers/provider_budgets.dart';
import '../../providers/provider_auth.dart';

class EditBudgetDialog extends StatefulWidget {
  const EditBudgetDialog({
    required this.personalBudget,
    required this.publicBudget,
    super.key,
  });

  final Budget? personalBudget;
  final Budget? publicBudget;

  @override
  State<EditBudgetDialog> createState() => _EditBudgetDialogState();
}

class _EditBudgetDialogState extends State<EditBudgetDialog> {
  late final ProviderAuth providerAuth;
  late final ProviderBudgets providerBudgets;
  final TextEditingController pubIncomeTextController = TextEditingController();
  final TextEditingController pubExpenseTextController =
      TextEditingController();
  final TextEditingController personalIncomeTextController =
      TextEditingController();
  final TextEditingController personalExpenseTextController =
      TextEditingController();

  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      providerAuth = Provider.of<ProviderAuth>(context);
      providerBudgets = Provider.of<ProviderBudgets>(context);
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    pubExpenseTextController.dispose();
    pubIncomeTextController.dispose();
    personalExpenseTextController.dispose();
    personalIncomeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Edit Budget',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Divider(),
                // Body
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Income',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Personal:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: personalIncomeTextController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      GlobalTextChecks.allowedBudgetCharacters)
                                ],
                                maxLength: 10,
                                decoration: InputDecoration(
                                  // FIXME Localization
                                  hintText:
                                      '${widget.personalBudget?.income ?? 0}€',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Public:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: pubIncomeTextController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  // FIXME Localization
                                  hintText:
                                      '${widget.publicBudget?.income ?? 0}€',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Expenses',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Personal:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: personalExpenseTextController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  // FIXME Localization
                                  hintText:
                                      '${widget.personalBudget?.expenses ?? 0}€',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Public:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: pubExpenseTextController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  // FIXME Localization
                                  hintText:
                                      '${widget.publicBudget?.expenses ?? 0}€',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            // FIXME Localization
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final double? privateIncome = double.tryParse(
                                  personalIncomeTextController.text);
                              final double? privateExpense = double.tryParse(
                                  personalExpenseTextController.text);
                              final double? publicIncome =
                                  double.tryParse(pubIncomeTextController.text);
                              final double? publicExpense = double.tryParse(
                                  pubExpenseTextController.text);
                              providerBudgets
                                  .editBudget(
                                    jwt: providerAuth.jwt,
                                    privateIncome: privateIncome,
                                    privateExpense: privateExpense,
                                    publicIncome: publicIncome,
                                    publicExpense: publicExpense,
                                  )
                                  .then((value) => Navigator.pop(context));
                            },
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary)),
                            // FIXME Localization
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
