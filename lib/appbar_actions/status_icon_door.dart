import 'package:flutter/material.dart';
import './status_icon.dart';

/// Shows the status of the garage door
class DoorStatusIcon extends StatelessWidget {
  const DoorStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO Implement
    return StatusIcon(
      child: Row(
        children: const [
          Icon(Icons.garage),
          Text('closed'),
        ],
      ),
    );
  }
}
