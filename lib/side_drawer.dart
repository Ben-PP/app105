import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  Widget buildButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        child: IconButton(
          iconSize: 60,
          onPressed: onPressed,
          icon: Icon(
            icon,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Home
            buildButton(
                icon: Icons.home_rounded,
                onPressed: () {
                  Navigator.pop(context);
                }),
            // Settings
            buildButton(
                icon: Icons.settings_rounded,
                onPressed: () {
                  //
                }),
          ],
        ),
      ),
    );
  }
}
