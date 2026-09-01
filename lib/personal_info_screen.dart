import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('profile_name') ?? 'Sarah Malek';
    emailController.text =
        prefs.getString('profile_email') ?? 'sarah.malek@gmail.com';
    phoneController.text = prefs.getString('profile_phone') ?? '';
    setState(() => _loading = false);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_name', nameController.text.trim());
    await prefs.setString('profile_email', emailController.text.trim());
    await prefs.setString('profile_phone', phoneController.text.trim());

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved')),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
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
          'Personal Information',
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
                _label('FULL NAME'),
                _field(nameController),

                const SizedBox(height: 18),

                _label('EMAIL ADDRESS'),
                _field(emailController,
                    keyboardType: TextInputType.emailAddress),

                const SizedBox(height: 18),

                _label('PHONE NUMBER'),
                _field(
                  phoneController,
                  keyboardType: TextInputType.phone,
                  hint: 'Add a phone number',
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0066B3),
                      foregroundColor: const Color(0xFFC9F36A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF777777),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    String? hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Color(0xFF0066B3)),
        ),
      ),
    );
  }
}