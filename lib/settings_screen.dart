import 'package:flutter/material.dart';
import 'package:myapp/profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF1F1F1F),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications', style: TextStyle(color: Colors.white)),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications, color: Color(0xFFBB86FC)),
             activeColor: const Color(0xFFBB86FC),
          ),
          SwitchListTile(
            title: const Text('Dark Mode', style: TextStyle(color: Colors.white)),
            value: _darkModeEnabled,
            onChanged: (bool value) {
              setState(() {
                _darkModeEnabled = value;
                // This is a placeholder for theme switching logic
                // In a real app, you would use a theme provider to change the theme
              });
            },
            secondary: const Icon(Icons.dark_mode, color: Color(0xFFBB86FC)),
            activeColor: const Color(0xFFBB86FC),
          ),
          ListTile(
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.person, color: Color(0xFFBB86FC)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Account', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.account_circle, color: Color(0xFFBB86FC)),
            onTap: () {
              // Navigate to account settings
            },
          ),
          ListTile(
            title: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.privacy_tip, color: Color(0xFFBB86FC)),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
           ListTile(
            title: const Text('About', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.info, color: Color(0xFFBB86FC)),
            onTap: () {
              // Navigate to about page
            },
          ),
        ],
      ),
    );
  }
}
