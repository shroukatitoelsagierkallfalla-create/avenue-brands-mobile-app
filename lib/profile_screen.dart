import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'search_screen.dart';
import 'settings_screen.dart';
import 'onboarding_screen.dart';
import 'cart_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Mariam Nabil';
  String email = 'mariam@email.com';
  String phone = '+20 10 XXX XXXX';
  String location = 'Alexandria, Egypt';

  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not select the photo.'),
        ),
      );
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCCCCC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Change Profile Photo',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 18),

                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFF0066B3),
                  ),
                  title: const Text('Take Photo'),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    _pickImage(
                      ImageSource.camera,
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: Color(0xFF0066B3),
                  ),
                  title: const Text(
                    'Choose from Gallery',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    _pickImage(
                      ImageSource.gallery,
                    );
                  },
                ),

                if (_profileImage != null)
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Remove Photo',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);

                      setState(() {
                        _profileImage = null;
                      });
                    },
                  ),

                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditProfileDialog() {
    final nameController =
        TextEditingController(text: name);

    final phoneController =
        TextEditingController(text: phone);

    final locationController =
        TextEditingController(text: location);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text.trim();
                  phone = phoneController.text.trim();
                  location =
                      locationController.text.trim();
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const Text(
          'Are you sure you want to log out?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancel'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen(),
                ),
                (route) => false,
              );
            },
            child: const Text('Log Out'),
          ),
        ],
      );
    },
  );
}

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 155,
              width: double.infinity,
              color: const Color(0xFF0066B3),

              child: Stack(
                children: [
                  Positioned(
                    left: 8,
                    top: 5,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  const Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Color(0xFFC9F36A),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 15,
                    top: 12,
                    child: IconButton(
                      onPressed: _openSettings,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 35,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _showPhotoOptions,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: _profileImage != null
                                    ? Image.file(
                                        _profileImage!,
                                        width: 85,
                                        height: 85,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.person_outline,
                                        color: Colors.black,
                                        size: 65,
                                      ),
                              ),
                            ),

                            Positioned(
                              right: -2,
                              bottom: -2,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFC9F36A,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color(0xFF0066B3),
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 7,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFFC9F36A),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed:
                              _showEditProfileDialog,
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF0066B3),
                            foregroundColor:
                                Colors.white,
                            elevation: 0,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        'MY ACCOUNT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFBDBDBD),
                          ),
                          borderRadius:
                              BorderRadius.circular(9),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                color: Color(0xFF0066B3),
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              email,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              'Phone',
                              style: TextStyle(
                                color: Color(0xFF0066B3),
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              phone,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              'Location',
                              style: TextStyle(
                                color: Color(0xFF0066B3),
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 2),

                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'MY SHOPPING',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        width: double.infinity,
                        height: 85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFBDBDBD),
                          ),
                          borderRadius:
                              BorderRadius.circular(9),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Wishlist',
                                    style: TextStyle(
                                      color:
                                          Color(0xFF0066B3),
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: 1,
                              height: 50,
                              color:
                                  const Color(0xFFE5E5E5),
                            ),

                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Orders',
                                    style: TextStyle(
                                      color:
                                          Color(0xFF0066B3),
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    '3',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 38),

                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: _showLogoutDialog,
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF0066B3),
                            foregroundColor:
                                const Color(0xFFC9F36A),
                            elevation: 0,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            const ProfileBottomNavigation(),
          ],
        ),
      ),
    );
  }
}

class ProfileBottomNavigation extends StatelessWidget {
  const ProfileBottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEDEDED),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          ProfileNavItem(
            icon: Icons.home_outlined,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ProfileNavItem(
            icon: Icons.search,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const SearchScreen(),
                ),
              );
            },
          ),

          ProfileNavItem(
            icon: Icons.compare_arrows,
            onTap: () {},
          ),

          ProfileNavItem(
            icon: Icons.shopping_cart_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CartScreen(),
                ),
              );
            },
          ),

          ProfileNavItem(
            icon: Icons.person_outline,
            active: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ProfileNavItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const ProfileNavItem({
    super.key,
    required this.icon,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 48,
        height: 60,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 21,
              color: const Color(0xFF555555),
            ),

            const SizedBox(height: 3),

            if (active)
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Color(0xFFC9F36A),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}