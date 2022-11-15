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
  late final double screenWidth;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      screenHeight = (MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top) -
          (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top) *
              SizesGlobal.appBarHeight;
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
                const Text('0'),
                Container(
                  color: Colors.black,
                  height: 10,
                  width: 2,
                ),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey,
                  ),
                  clipBehavior: Clip.hardEdge,
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
