import 'package:flutter/material.dart';

import './globals.dart';
import './side_drawer.dart';
import './budget/budget_page.dart';

/// Home page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State for home page
class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> tabs = [
    // TODO Implement shopping list
    {
      'widget': Container(),
      'title': 'Shop',
    },
    // TODO Implement budjet page
    {
      'widget': const BudgetPage(),
      'title': BudgetPage.appBarTitle,
    },
    // TODO Implement home page
    {
      'widget': Container(),
      'title': 'Home',
    },
    // TODO Implement TODO list
    {
      'widget': Container(),
      'title': 'TODO',
    },
    // TODO Implement monitoring page
    {
      'widget': Container(),
      'title': 'Monitor',
    },
  ];

  late final double screenHeight;
  var currentIndex = 2;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      screenHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top;

      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: screenHeight * SizesGlobal.appBarHeight,
        title: Text((tabs[currentIndex]['title'])),
        centerTitle: true,
      ),
      drawer: const SideDrawer(),
      body: tabs[currentIndex]['widget'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.euro),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'TODO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: 'Monitor',
          ),
        ],
      ),
    );
  }
}
