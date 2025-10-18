import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildActivitySummary(),
              const SizedBox(height: 24),
              _buildWorkoutSuggestions(),
              const SizedBox(height: 24),
              _buildNutritionTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning, User!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '"The only bad workout is the one that didn\'t happen."',
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildActivitySummary() {
    return Card(
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ActivityStat(icon: Icons.directions_walk, value: '8,500', label: 'Steps'),
            _ActivityStat(icon: Icons.local_fire_department, value: '350', label: 'Calories'),
            _ActivityStat(icon: Icons.opacity, value: '6/8', label: 'Water'),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Workout Suggestions',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _WorkoutCard(
                image: 'assets/images/workout1.jpg',
                title: 'Full Body Strength',
                duration: '45 min',
              ),
              _WorkoutCard(
                image: 'assets/images/workout2.jpg',
                title: 'Cardio Blast',
                duration: '30 min',
              ),
              _WorkoutCard(
                image: 'assets/images/workout3.jpg',
                title: 'Yoga & Flexibility',
                duration: '60 min',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nutrition Tips',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const ListTile(
            leading: Icon(Icons.emoji_food_beverage, color: Color(0xFFBB86FC)),
            title: Text('Stay Hydrated', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text('Drink at least 8 glasses of water a day to keep your body functioning optimally.', style: TextStyle(color: Colors.white70)),
          ),
        ),
      ],
    );
  }
}

class _ActivityStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _ActivityStat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFBB86FC), size: 30),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white70)),
      ],
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final String image;
  final String title;
  final String duration;

  const _WorkoutCard({required this.image, required this.title, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              height: 120,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          Text(duration, style: const TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }
}
