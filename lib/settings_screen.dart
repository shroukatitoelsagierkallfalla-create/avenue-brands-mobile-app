import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'personal_info_screen.dart';
import 'privacy_screen.dart';
import 'notifications_screen.dart';
import 'help_center_screen.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmLogOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Color(0xFF0066B3),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('profile_name');
      await prefs.remove('profile_email');
      await prefs.remove('profile_phone');

      if (!context.mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF0066B3),
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),

        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFFC9F36A),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),

        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 25,
        ),
        children: [
          const Text(
            'ACCOUNT',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0066B3),
            ),
          ),

          const SizedBox(height: 12),

          _settingItem(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalInfoScreen(),
                ),
              );
            },
          ),

          _settingItem(
            icon: Icons.lock_outline,
            title: 'Privacy',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          const Text(
            'PREFERENCES',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0066B3),
            ),
          ),

          const SizedBox(height: 12),

          _settingItem(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),

          // Language: static, English only for now.
          _staticItem(
            icon: Icons.language_outlined,
            title: 'Language',
            value: 'English',
          ),

          // Appearance: static, light only for now (dark mode removed).
          _staticItem(
            icon: Icons.dark_mode_outlined,
            title: 'Appearance',
            value: 'Light',
          ),

          const SizedBox(height: 25),

          const Text(
            'SUPPORT',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0066B3),
            ),
          ),

          const SizedBox(height: 12),

          _settingItem(
            icon: Icons.help_outline,
            title: 'Help Center',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpCenterScreen(),
                ),
              );
            },
          ),

          _settingItem(
            icon: Icons.info_outline,
            title: 'About Avenue',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () => _confirmLogOut(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066B3),
                foregroundColor: const Color(0xFFC9F36A),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: ListTile(
        onTap: onTap,

        leading: Icon(
          icon,
          color: const Color(0xFF0066B3),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Color(0xFF777777),
        ),
      ),
    );
  }

  // Non-interactive row: shows a fixed value, no arrow, no onTap.
  Widget _staticItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF0066B3),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF777777),
          ),
        ),
      ),
    );
  }
}