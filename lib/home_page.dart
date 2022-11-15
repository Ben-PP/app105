import 'package:flutter/material.dart';

import './appbar_actions/status_icon_server.dart';
import './appbar_actions/status_icon_door.dart';
import './appbar_actions/status_icon_lights.dart';
import './appbar_actions/status_icon_temp.dart';
import './side_drawer.dart';

/// Home page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State for home page
class _HomePageState extends State<HomePage> {
  final List<Widget> tabs = [
    // TODO Implement home page
    // TODO Implement budjet page
    // TODO Implement shopping list
    // TODO Implement TODO list
    // TODO Implement monitoring page
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [
          StatusIconServer(),
          DoorStatusIcon(),
          StatusIconLights(),
          StatusIconTemperature(),
        ],
      ),
      drawer: const SideDrawer(),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
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
