
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityLogScreen extends StatelessWidget {
  final List<Map<String, dynamic>> activityLog;

  const ActivityLogScreen({super.key, required this.activityLog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Log'),
        backgroundColor: const Color(0xFF2C2C2C),
      ),
      body: ListView.builder(
        itemCount: activityLog.length,
        itemBuilder: (context, index) {
          final activity = activityLog[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: const Color(0xFF2C2C2C),
            child: ListTile(
              leading: Icon(activity['icon'], color: Colors.white),
              title: Text(activity['type'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(
                '${DateFormat.yMd().add_jms().format(activity['time'])} - ${activity['duration']} - ${activity['distance']} km',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          );
        },
      ),
    );
  }
}
