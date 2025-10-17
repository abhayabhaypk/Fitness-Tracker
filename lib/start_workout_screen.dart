
import 'package:flutter/material.dart';
import 'package:myapp/workout_screen.dart';

class StartWorkoutScreen extends StatelessWidget {
  const StartWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start a Workout'),
        backgroundColor: const Color(0xFF1F1F1F),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildWorkoutType(context, 'Running', Icons.directions_run),
          _buildWorkoutType(context, 'Cycling', Icons.directions_bike),
          _buildWorkoutType(context, 'Weightlifting', Icons.fitness_center),
          _buildWorkoutType(context, 'Yoga', Icons.self_improvement),
          _buildWorkoutType(context, 'HIIT', Icons.timer),
        ],
      ),
    );
  }

  Widget _buildWorkoutType(BuildContext context, String type, IconData icon) {
    return Card(
      color: const Color(0xFF2C2C2C),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFBB86FC), size: 40),
        title: Text(type, style: const TextStyle(fontSize: 20, color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutScreen(workoutType: type),
            ),
          );
        },
      ),
    );
  }
}
