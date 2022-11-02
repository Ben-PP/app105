import 'package:flutter/material.dart';
import './status_icon.dart';

class StatusIconLights extends StatelessWidget {
  const StatusIconLights({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatusIcon(child: Icon(Icons.lightbulb_rounded));
  }
}
