import 'package:flutter/material.dart';

class PersonalGoalsScreen extends StatefulWidget {
  const PersonalGoalsScreen({super.key});

  @override
  _PersonalGoalsScreenState createState() => _PersonalGoalsScreenState();
}

class _PersonalGoalsScreenState extends State<PersonalGoalsScreen> {
  final TextEditingController _goalController = TextEditingController();
  int _currentGoal = 10000; // Example initial goal

  @override
  void initState() {
    super.initState();
    _goalController.text = _currentGoal.toString();
  }

  void _saveGoal() {
    setState(() {
      _currentGoal = int.tryParse(_goalController.text) ?? _currentGoal;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Goal saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Goals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Your Daily Step Goal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Daily Steps',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveGoal,
              child: const Text('Save Goal'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Current Goal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '$_currentGoal steps',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
