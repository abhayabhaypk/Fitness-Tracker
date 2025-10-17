
import 'package:flutter/material.dart';

class SavedWorkoutsScreen extends StatelessWidget {
  const SavedWorkoutsScreen({super.key});

  // Mock data for saved workouts
  final List<Map<String, String>> savedWorkouts = const [
    {'type': 'Running', 'duration': '00:30:15', 'date': '2024-07-28'},
    {'type': 'Weightlifting', 'duration': '01:15:45', 'date': '2024-07-27'},
    {'type': 'Cycling', 'duration': '00:45:20', 'date': '2024-07-26'},
    {'type': 'Yoga', 'duration': '01:00:00', 'date': '2024-07-25'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Workouts'),
        backgroundColor: const Color(0xFF1F1F1F),
      ),
      body: ListView.builder(
        itemCount: savedWorkouts.length,
        itemBuilder: (context, index) {
          final workout = savedWorkouts[index];
          return Card(
            color: const Color(0xFF2C2C2C),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(_getIconForWorkoutType(workout['type']!), color: const Color(0xFFBB86FC), size: 40),
              title: Text(workout['type']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              subtitle: Text(
                'Duration: ${workout['duration']}\nDate: ${workout['date']}',
                style: const TextStyle(color: Colors.white70),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }

  IconData _getIconForWorkoutType(String type) {
    switch (type) {
      case 'Running':
        return Icons.directions_run;
      case 'Weightlifting':
        return Icons.fitness_center;
      case 'Cycling':
        return Icons.directions_bike;
      case 'Yoga':
        return Icons.self_improvement;
      default:
        return Icons.sports;
    }
  }
}
