import 'package:flutter/material.dart';

import '../globals.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  // FIXME Localization
  static const appBarTitle = 'Budget';

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late final double screenHeight;
  late final double screenWidth;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
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
                const Text('Balance'),
                Container(
                  color: Colors.black,
                  height: 10,
                  width: 2,
                ),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey,
                  ),
                  clipBehavior: Clip.hardEdge,
                  // TODO Implement the balance bar
                  // TODO Add saving target
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth * 0.9 * 0.5,
                        height: double.infinity,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  height: 10,
                  width: 2,
                ),
                const Text('0€'),

                // Static transactions
                // FIXME Localization
                const Text('Monthly budget'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Income
                    SizedBox(
                      width: screenWidth * 0.3,
                      child: Column(
                        children: [
                          // FIXME Localization
                          const Text('Income'),
                          TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(2),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expenses
                    SizedBox(
                      width: screenWidth * 0.3,
                      child: Column(
                        children: [
                          // FIXME Localization
                          const Text('Expenses'),
                          TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(2),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    // TODO Save income/expenses
                  },
                  child: Text(
                    // FIXME Localization
                    'Save Income/Expenses',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),

                // TODO Add ability to add quick transactions
                // Saved transactions
                // FIXME Localization
                const Text('Quick Transactions'),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () {
                      // TODO Manage quick transactions
                    },
                    child: Text(
                      // FIXME Localization
                      'Manage',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
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
