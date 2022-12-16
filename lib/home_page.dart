import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './globals.dart';
import './widgets/side_drawer.dart';
import './budget/budget_page.dart';

import './providers/provider_api.dart';
import './providers/provider_auth.dart';

/// Home page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State for home page
class _HomePageState extends State<HomePage> {
  late final ProviderApi providerApi;
  late final ProviderAuth providerAuth;
  late final List<Map<String, dynamic>> tabs;

  late final double screenHeight;
  var currentIndex = 2;
  var isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      tabs = [
        // TODO Implement shopping list
        {
          'widget': Container(),
          'title': 'Shop',
          'actions': <IconButton>[],
        },
        // TODO Implement budjet page
        {
          'widget': const BudgetPage(),
          'title': BudgetPage.appBarTitle,
          'actions': <IconButton>[],
        },
        // TODO Implement home page
        {
          'widget': Container(),
          'title': 'Home',
          'actions': <IconButton>[],
        },
        // TODO Implement TODO list
        {
          'widget': Container(),
          'title': 'TODO',
          'actions': <IconButton>[],
        },
        // TODO Implement monitoring page
        {
          'widget': Container(),
          'title': 'Monitor',
          'actions': <IconButton>[],
        },
      ];
      screenHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top;

      providerApi = Provider.of<ProviderApi>(context);
      providerAuth = Provider.of<ProviderAuth>(context);
      providerApi.connect().then((value) {
        providerAuth.validateJWT();
      });
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: screenHeight * GlobalSizes.appBarHeight,
        title: Text((tabs[currentIndex]['title'])),
        centerTitle: true,
        actions: tabs[currentIndex]['actions'],
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
