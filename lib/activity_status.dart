
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class ActivityStatus extends StatefulWidget {
  const ActivityStatus({super.key});

  @override
  _ActivityStatusState createState() => _ActivityStatusState();
}

class _ActivityStatusState extends State<ActivityStatus> {
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  Future<void> initPlatformState() async {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1F1F1F),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Activity Status', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white70)),
            const SizedBox(height: 10),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.device_unknown,
              size: 80,
              color: const Color(0xFFBB86FC),
            ),
            const SizedBox(height: 10),
            Text(
              _status.toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _status == 'walking'
                    ? Colors.green
                    : _status == 'stopped'
                        ? Colors.orange
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
