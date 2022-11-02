import 'package:flutter/material.dart';

class DoorControls extends StatelessWidget {
  const DoorControls({super.key});

  Widget buildButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Icon(
            icon,
            size: 60,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Door Controls',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          buildButton(
            icon: Icons.keyboard_arrow_up_rounded,
            onPressed: () {
              // TODO Open garage door
            },
          ),
          buildButton(
            icon: Icons.stop_rounded,
            onPressed: () {
              // TODO Stop garage door
            },
          ),
          buildButton(
            icon: Icons.keyboard_arrow_down_rounded,
            onPressed: () {
              // TODO Close garage door
            },
          ),
        ],
      ),
    );
  }
}
