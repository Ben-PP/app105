import 'package:flutter/material.dart';

import '../appbar_actions/status_icon_server.dart';
import '../appbar_actions/status_icon_door.dart';
import '../appbar_actions/status_icon_lights.dart';
import '../appbar_actions/status_icon_temp.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static const routeName = 'settings_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: const [
          StatusIconServer(),
          DoorStatusIcon(),
          StatusIconLights(),
          StatusIconTemperature(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: const [
            // Server
            Text(
              'Server',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
