import 'package:flutter/material.dart';
import './status_icon.dart';

/// Shows the temperature
class StatusIconTemperature extends StatelessWidget {
  const StatusIconTemperature({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO Implement
    return const StatusIcon(child: Text('22°C'));
  }
}
