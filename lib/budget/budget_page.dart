import 'package:flutter/material.dart';

import '../globals.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  static const appBarTitle = 'Budget';

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late final double screenHeight;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      screenHeight = (MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top) -
          (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top) *
              SizesGlobal.appBarHeight;

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
          Column(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, right: 15),
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                isExtended: false,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
