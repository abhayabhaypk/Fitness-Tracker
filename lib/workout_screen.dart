
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wakelock_plus/wakelock_plus.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  bool _isRunning = false;
  String _elapsedTime = '00:00:00';

  @override
  void initState() {
    super.initState();
  }

  void _startStopwatch() {
    if (!_isRunning) {
      WakelockPlus.enable();
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          _elapsedTime = _formatElapsedTime(_stopwatch.elapsed);
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _pauseStopwatch() {
    if (_isRunning) {
      WakelockPlus.disable();
      _stopwatch.stop();
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void _resetStopwatch() {
    _pauseStopwatch();
    _stopwatch.reset();
    setState(() {
      _elapsedTime = '00:00:00';
    });
  }

  String _formatElapsedTime(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Session'),
        backgroundColor: const Color(0xFF2C2C2C),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _elapsedTime,
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_isRunning)
                  ElevatedButton.icon(
                    onPressed: _startStopwatch,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                if (_isRunning)
                  ElevatedButton.icon(
                    onPressed: _pauseStopwatch,
                    icon: const Icon(Icons.pause),
                    label: const Text('Pause'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _resetStopwatch,
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
