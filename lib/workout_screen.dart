
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wakelock_plus/wakelock_plus.dart';

class WorkoutScreen extends StatefulWidget {
  final String workoutType;

  const WorkoutScreen({super.key, required this.workoutType});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
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
      _timer?.cancel();
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

  void _saveWorkout() {
    // In a real app, this would save the workout to a log.
    final duration = _stopwatch.elapsed;
    final workoutType = widget.workoutType;
    
    print('Saving workout: $workoutType, Duration: ${_formatElapsedTime(duration)}');

    _resetStopwatch();
    
    // Pop twice to get back to the main dashboard
    Navigator.pop(context);
    Navigator.pop(context);
  }

  String _formatElapsedTime(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutType),
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
                  )
                else
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
                  label: const Text('Stop & Discard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (!_isRunning && _stopwatch.elapsedMilliseconds > 0)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  onPressed: _saveWorkout,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Workout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBB86FC),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
