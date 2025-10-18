import 'package:flutter/material.dart';
import 'package:myapp/activity_history_screen.dart';
import 'package:myapp/personal_goals_screen.dart';
import 'package:myapp/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF1F1F1F),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Placeholder for editing profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildProfileOption(context, 'Activity History', Icons.history, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ActivityHistoryScreen()),
              );
            }),
            _buildProfileOption(context, 'Personal Goals', Icons.flag, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PersonalGoalsScreen()),
              );
            }),
            _buildProfileOption(context, 'Settings', Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            }),
            const SizedBox(height: 20),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return const Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
        ),
        SizedBox(height: 16),
        Text(
          'james',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'james@gmail.com',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      color: const Color(0xFF2C2C2C),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFBB86FC)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Logout'),
      onPressed: () {
        // Placeholder for logout functionality
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
