import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool shareActivity = true;
  bool personalizedAds = false;
  bool locationAccess = true;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      shareActivity = prefs.getBool('privacy_share_activity') ?? true;
      personalizedAds =
          prefs.getBool('privacy_personalized_ads') ?? false;
      locationAccess =
          prefs.getBool('privacy_location_access') ?? true;
      _loading = false;
    });
  }

  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0066B3),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Privacy',
          style: TextStyle(
            color: Color(0xFFC9F36A),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25,
              ),
              children: [
                _switchTile(
                  'Share Activity',
                  'Let Avenue use your browsing to improve suggestions',
                  shareActivity,
                  (v) {
                    setState(() => shareActivity = v);
                    _saveBool('privacy_share_activity', v);
                  },
                ),
                _switchTile(
                  'Personalized Ads',
                  'Show ads based on your interests',
                  personalizedAds,
                  (v) {
                    setState(() => personalizedAds = v);
                    _saveBool('privacy_personalized_ads', v);
                  },
                ),
                _switchTile(
                  'Location Access',
                  'Used to show nearby stores and deliveries',
                  locationAccess,
                  (v) {
                    setState(() => locationAccess = v);
                    _saveBool('privacy_location_access', v);
                  },
                ),
              ],
            ),
    );
  }

  Widget _switchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(9),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        activeThumbColor: const Color(0xFF0066B3),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF777777),
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}