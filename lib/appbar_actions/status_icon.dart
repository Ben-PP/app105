import 'package:flutter/material.dart';

/// Used for action icons in the appbar
class StatusIcon extends StatelessWidget {
  const StatusIcon({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TODO Implement onPressed()
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(child: child),
    );
  }
}
