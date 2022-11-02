import 'package:flutter/material.dart';
import './status_icon.dart';

/// Shows the status of connection to server
class StatusIconServer extends StatelessWidget {
  const StatusIconServer({super.key});

  // TODO Implement
  @override
  Widget build(BuildContext context) {
    return StatusIcon(
      child: Row(
        children: const [
          Icon(Icons.signal_wifi_4_bar),
          Text('50ms'),
        ],
      ),
    );
  }
}
