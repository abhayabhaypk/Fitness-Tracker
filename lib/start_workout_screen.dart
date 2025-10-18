
import 'package:flutter/material.dart';
import 'package:myapp/workout_screen.dart';
import 'package:myapp/saved_workouts_screen.dart';

class StartWorkoutScreen extends StatelessWidget {
  const StartWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start a Workout'),
        backgroundColor: const Color(0xFF1F1F1F),
        actions: [
          IconButton(
            icon: const Icon(Icons.saved_search, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedWorkoutsScreen()),
              );
            },
            tooltip: 'Saved Workouts',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInstructionalBanner(),
            const SizedBox(height: 20),
            _buildWorkoutType(context, 'Running', Icons.directions_run, 'Outdoor and treadmill'),
            _buildWorkoutType(context, 'Cycling', Icons.directions_bike, 'Road and stationary'),
            _buildWorkoutType(context, 'Weightlifting', Icons.fitness_center, 'Strength and conditioning'),
            _buildWorkoutType(context, 'Yoga', Icons.self_improvement, 'Flexibility and meditation'),
            _buildWorkoutType(context, 'HIIT', Icons.timer, 'High-Intensity Interval Training'),
            const SizedBox(height: 20),
            _buildCustomWorkoutCard(context),
            const SizedBox(height: 10),
            _buildStartEmptyWorkoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionalBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF03DAC6)),
      ),
    );
  }

  Widget _buildWorkoutType(BuildContext context, String type, IconData icon, String description) {
    return Card(
      color: const Color(0xFF2C2C2C),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFBB86FC), size: 40),
        title: Text(type, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(description, style: const TextStyle(color: Colors.white70)),
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

  Widget _buildCustomWorkoutCard(BuildContext context) {
    return Card(
      color: const Color(0xFF1F1F1F),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Placeholder for custom workout creation
        },
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Color(0xFF03DAC6), size: 30),
              SizedBox(width: 10),
              Text('Create a Custom Workout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartEmptyWorkoutButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.play_circle_outline, size: 28),
      label: const Text('Start Empty Workout', style: TextStyle(fontSize: 18)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WorkoutScreen(workoutType: 'Freestyle'),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFF03DAC6),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
