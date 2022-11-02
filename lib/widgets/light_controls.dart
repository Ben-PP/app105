import 'package:flutter/material.dart';

class LightControls extends StatelessWidget {
  const LightControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Light',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 212,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // TODO Implement
                },
                child: const Icon(
                  Icons.lightbulb_rounded,
                  size: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
