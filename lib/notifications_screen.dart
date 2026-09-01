import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool orderUpdates = true;
  bool promotions = false;
  bool priceDrops = true;
  bool newArrivals = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      orderUpdates = prefs.getBool('notif_order_updates') ?? true;
      promotions = prefs.getBool('notif_promotions') ?? false;
      priceDrops = prefs.getBool('notif_price_drops') ?? true;
      newArrivals = prefs.getBool('notif_new_arrivals') ?? false;
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
          'Notifications',
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              children: [
                _switchTile(
                  title: 'Order Updates',
                  value: orderUpdates,
                  onChanged: (v) {
                    setState(() => orderUpdates = v);
                    _saveBool('notif_order_updates', v);
                  },
                ),
                _switchTile(
                  title: 'Promotions & Offers',
                  value: promotions,
                  onChanged: (v) {
                    setState(() => promotions = v);
                    _saveBool('notif_promotions', v);
                  },
                ),
                _switchTile(
                  title: 'Price Drops',
                  value: priceDrops,
                  onChanged: (v) {
                    setState(() => priceDrops = v);
                    _saveBool('notif_price_drops', v);
                  },
                ),
                _switchTile(
                  title: 'New Arrivals',
                  value: newArrivals,
                  onChanged: (v) {
                    setState(() => newArrivals = v);
                    _saveBool('notif_new_arrivals', v);
                  },
                ),
              ],
            ),
    );
  }

  Widget _switchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(9),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        activeThumbColor: const Color(0xFF0066B3),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}