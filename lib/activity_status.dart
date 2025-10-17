
import 'package:flutter/material.dart';

class ActivityStatus extends StatelessWidget {
  final int steps;
  final int goal;

  const ActivityStatus({
    super.key,
    this.steps = 0,
    this.goal = 10000,
  });

  @override
  Widget build(BuildContext context) {
    double progress = goal > 0 ? steps / goal : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F), // Dark theme background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daily Goal: $goal steps',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 20,
                    backgroundColor: Colors.grey[850],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white38),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Steps',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$steps',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
