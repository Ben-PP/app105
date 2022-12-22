import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals.dart';
import './budget_scale.dart';
import '../widgets/dialogs/edit_budget_dialog.dart';

import '../providers/provider_auth.dart';
import '../providers/provider_budgets.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  // FIXME Localization
  static const appBarTitle = 'Budget';

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late final ProviderAuth providerAuth;
  late final ProviderBudgets providerBudgets;
  late final double screenHeight;
  late final double screenWidth;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      providerAuth = Provider.of<ProviderAuth>(context);
      providerBudgets = Provider.of<ProviderBudgets>(context);
      providerBudgets.fetchBudgets(jwt: providerAuth.jwt);
      screenHeight = (MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top) -
          (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top) *
              GlobalSizes.appBarHeight;
      screenWidth = MediaQuery.of(context).size.width;

      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: screenHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: Column(
              children: [
                // FIXME Localization
                /*SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Balance',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),*/
                // TODO Fetch the numbers
                BudgetScale(
                  width: screenWidth * 0.85,
                  title: 'House hold',
                  total: providerBudgets.houseBudget?.balance ?? 0,
                  income: providerBudgets.houseBudget?.totalPositive ?? 0,
                ),
                // TODO Fetch the numbers
                BudgetScale(
                  width: screenWidth * 0.85,
                  title: 'Personal',
                  total: (providerBudgets.privateBudget?.balance ?? 0),
                  income: providerBudgets.privateBudget?.totalPositive ?? 0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return EditBudgetDialog(
                            personalBudget: providerBudgets.privateBudget,
                            publicBudget: providerBudgets.publicBudget,
                          );
                        });
                  },
                  child: Text(
                    // FIXME Localization
                    'Edit Budget',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),

                // Static transactions
                // FIXME Localization
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Transactions',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                // TODO Add gridview for quick transactions
                //      Separate expenses and incomes.
                // TODO Add list of transactions
              ],
            ),
          ),
          // Floating action button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, right: 15),
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
