import 'package:flutter/material.dart';

class ActivityHistoryScreen extends StatelessWidget {
  const ActivityHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity History'),
      ),
      body: ListView.builder(
        itemCount: 20, // Example item count
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.fitness_center),
            title: Text('Workout ${index + 1}'),
            subtitle: Text('Date: ${DateTime.now().subtract(Duration(days: index))}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle tapping on a specific workout
            },
          );
        },
      ),
    );
  }
}
