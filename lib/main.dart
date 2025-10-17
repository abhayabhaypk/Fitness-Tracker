
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:myapp/history_screen.dart';
import 'package:myapp/activity_log_screen.dart';
import 'package:myapp/start_workout_screen.dart';
import 'package:myapp/nutrition_screen.dart';
import 'package:myapp/activity_status.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFBB86FC),
        hintColor: const Color(0xFF03DAC6),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const FitnessTracker(),
    );
  }
}

class FitnessTracker extends StatefulWidget {
  const FitnessTracker({super.key});

  @override
  _FitnessTrackerState createState() => _FitnessTrackerState();
}

class _FitnessTrackerState extends State<FitnessTracker> with TickerProviderStateMixin {
  late Stream<StepCount> _stepCountStream;
  String _steps = '0';
  int _dailyGoal = 10000;
  final int _streak = 5; // Example streak
  final TextEditingController _goalController = TextEditingController();
  Map<String, int> _stepHistory = {};
  List<Map<String, dynamic>> _activityLog = [];
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _setupAnimations();
    _loadData();
  }

  void _setupAnimations() {
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
  }

  void _loadData() {
    // In a real app, you would load this from storage
    _stepHistory = {
      '2024-05-20': 8765,
      '2024-05-21': 9234,
      '2024-05-22': 11098,
      '2024-05-23': 7345,
      '2024-05-24': 12543,
    };
    _activityLog = [
      {
        'type': 'Walking',
        'icon': Icons.directions_walk,
        'time': DateTime.now().subtract(const Duration(hours: 2)),
        'duration': '30 min',
        'distance': '2.5'
      },
      {
        'type': 'Running',
        'icon': Icons.directions_run,
        'time': DateTime.now().subtract(const Duration(hours: 5)),
        'duration': '20 min',
        'distance': '4.0'
      },
      {
        'type': 'Cycling',
        'icon': Icons.directions_bike,
        'time': DateTime.now().subtract(const Duration(days: 1)),
        'duration': '1 hour',
        'distance': '15.0'
      },
    ];
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
      double progress = (int.tryParse(_steps) ?? 0) / _dailyGoal;
      _progressController.animateTo(progress > 1 ? 1 : progress);
    });
  }

  void onStepCountError(error) {
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  Future<void> initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(onStepCount).onError(onStepCountError);
    }

    if (!mounted) return;
  }

  void _showGoalDialog() {
    _goalController.text = _dailyGoal.toString();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: const Text('Set Daily Goal', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _goalController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Enter your daily step goal',
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Color(0xFFBB86FC))),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _dailyGoal = int.tryParse(_goalController.text) ?? 10000;
                });
                Navigator.pop(context);
              },
              child: const Text('Set', style: TextStyle(color: Color(0xFFBB86FC))),
            ),
          ],
        );
      },
    );
  }

  void _navigateToHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryScreen(stepHistory: _stepHistory)),
    );
  }

  void _navigateToActivityLog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ActivityLogScreen(activityLog: _activityLog)),
    );
  }

  void _navigateToStartWorkoutScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StartWorkoutScreen()),
    );
  }

  void _navigateToNutritionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NutritionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Dashboard'),
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.fastfood), 
            onPressed: _navigateToNutritionScreen,
            tooltip: 'Track Nutrition',
          ),
          IconButton(
            icon: const Icon(Icons.directions_run),
            onPressed: _navigateToStartWorkoutScreen,
            tooltip: 'Start Workout',
          ),
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: _navigateToActivityLog,
            tooltip: 'Activity Log',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _navigateToHistory,
            tooltip: 'View History',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showGoalDialog,
            tooltip: 'Set Daily Goal',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStepCounter(),
          const SizedBox(height: 20),
          _buildStreakCounter(),
          const SizedBox(height: 20),
          const ActivityStatus(),
          const SizedBox(height: 20),
          _buildWorkoutCard(),
          const SizedBox(height: 20),
          _buildNutritionCard(),
        ],
      ),
    );
  }

  Widget _buildStepCounter() {
    return Card(
      color: const Color(0xFF1F1F1F),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Daily Goal: $_dailyGoal steps', style: const TextStyle(fontSize: 18, color: Colors.white70)),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: _progressAnimation.value,
                        strokeWidth: 15,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.lerp(Colors.red, const Color(0xFF03DAC6), _progressAnimation.value)!,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Steps', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                            Text(_steps, style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCounter() {
    return Card(
      color: const Color(0xFF1F1F1F),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_fire_department, color: Colors.orange, size: 40),
            const SizedBox(width: 20),
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  '$_streak Day Streak!',
                  textStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange),
                ),
              ],
              isRepeatingAnimation: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard() {
    return Card(
      color: const Color(0xFF1F1F1F),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: _navigateToStartWorkoutScreen,
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(Icons.fitness_center, color: Color(0xFF03DAC6), size: 50),
              SizedBox(height: 10),
              Text('Start a Workout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionCard() {
    return Card(
      color: const Color(0xFF1F1F1F),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: _navigateToNutritionScreen,
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(Icons.fastfood, color: Colors.green, size: 50),
              SizedBox(height: 10),
              Text('Track Nutrition', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
