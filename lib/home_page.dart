import 'package:flutter/material.dart';

import './appbar_actions/status_icon_server.dart';
import './appbar_actions/status_icon_door.dart';
import './appbar_actions/status_icon_lights.dart';
import './appbar_actions/status_icon_temp.dart';
import './widgets/door_controls.dart';
import './widgets/light_controls.dart';
import './side_drawer.dart';

/// Home page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State for home page
class _HomePageState extends State<HomePage> {
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LightControls(),
              DoorControls(),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
