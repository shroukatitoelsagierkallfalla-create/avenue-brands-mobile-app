import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Returns an error message if something is invalid, or null if everything
  // passes. Checked top to bottom so the user sees one issue at a time.
  String? _validate() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty) {
      return 'Please enter your full name';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(name)) {
      return 'Name can only contain letters';
    }

    if (email.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    if (password.isEmpty) {
      return 'Please enter a password';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must include an uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must include a lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must include a number';
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(password)) {
      return 'Password must include a special character';
    }

    if (confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),

              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),

                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Back button
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      // Avenue logo
                      Image.asset(
                        'assets/images/logo.png',
                        height: 90,
                      ),

                      const SizedBox(height: 24),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // FULL NAME FIELD
                      LoginInputField(
                        controller: nameController,
                        label: 'FULL NAME',
                        icon: Icons.person_outline,
                        showBorder: true,
                      ),

                      const SizedBox(height: 12),

                      // EMAIL FIELD
                      LoginInputField(
                        controller: emailController,
                        label: 'EMAIL ADDRESS',
                        icon: Icons.mail_outline,
                        showBorder: true,
                        suffix: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFFC9F36A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // PASSWORD FIELD
                      LoginInputField(
                        controller: passwordController,
                        label: 'PASSWORD',
                        icon: Icons.lock_outline,
                        obscureText: hidePassword,
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: Icon(
                            hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF777777),
                            size: 18,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // CONFIRM PASSWORD FIELD
                      LoginInputField(
                        controller: confirmPasswordController,
                        label: 'CONFIRM PASSWORD',
                        icon: Icons.lock_outline,
                        obscureText: hideConfirmPassword,
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              hideConfirmPassword = !hideConfirmPassword;
                            });
                          },
                          child: Icon(
                            hideConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF777777),
                            size: 18,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password must be 8+ characters and include an\n'
                          'uppercase letter, lowercase letter, number, and\n'
                          'special character.',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF999999),
                            height: 1.4,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // CREATE ACCOUNT BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            final error = _validate();
                            if (error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error)),
                              );
                              return;
                            }

                            print('Name: ${nameController.text}');
                            print('Email: ${emailController.text}');
                            print('Password: ${passwordController.text}');

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF111111),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // OR DIVIDER
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Color(0xFFE1E1E1),
                              thickness: 1,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: Color(0xFF777777),
                                fontSize: 10,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: Color(0xFFE1E1E1),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // GOOGLE BUTTON
                      SocialLoginButton(
                        text: 'Continue with Google',
                        icon: Icons.g_mobiledata_rounded,
                        iconColor: const Color(0xFFC9F36A),
                        onPressed: () {
                          print('Google pressed');
                        },
                      ),

                      const SizedBox(height: 12),

                      // APPLE BUTTON
                      SocialLoginButton(
                        text: 'Continue with Apple',
                        icon: Icons.apple,
                        iconColor: Colors.black,
                        onPressed: () {
                          print('Apple pressed');
                        },
                      ),

                      // Push sign-in text toward the bottom
                      const Spacer(),

                      const SizedBox(height: 50),

                      // ALREADY HAVE AN ACCOUNT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 11,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color(0xFF0057A8),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 26),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}