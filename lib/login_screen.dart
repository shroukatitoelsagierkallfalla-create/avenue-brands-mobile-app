import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // The text shown inside the email field.
  final TextEditingController emailController = TextEditingController(
    text: 'sarah.malek@gmail.com',
  );

  // Example password so the dots appear like your Figma design.
  final TextEditingController passwordController = TextEditingController(
    text: '12345678',
  );

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                      // Space above logo
                      const SizedBox(height: 72),

                      // Avenue logo
                      const AvenueLogo(),

                      const SizedBox(height: 30),

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

                      const SizedBox(height: 7),

                      // FORGOT PASSWORD
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            print('Forgot password pressed');
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            minimumSize: Size.zero,
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0057A8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // CONTINUE BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                           print('Email: ${emailController.text}');
                           print('Password: ${passwordController.text}');

                          Navigator.push(
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
                            'Continue',
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

                      // Push create-account text toward the bottom
                      const Spacer(),

                      const SizedBox(height: 50),

                      // CREATE ACCOUNT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 11,
                            ),
                          ),

                        GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  },
  child: const Text(
    'Create Account',
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


// =======================================================
// AVENUE LOGO
// =======================================================

class AvenueLogo extends StatelessWidget {
  const AvenueLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 42,

      child: Stack(
        alignment: Alignment.center,
        children: [
          // Avenue text
          const Positioned(
            top: 14,
            child: Text(
              'Avenue',
              style: TextStyle(
                color: Color(0xFFC9F36A),
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
              ),
            ),
          ),

          // Small blue part of the logo
          Positioned(
            top: 3,
            left: 33,
            child: Transform.rotate(
              angle: -0.08,
              child: Container(
                width: 8,
                height: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF2676B8),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// =======================================================
// INPUT FIELD
// =======================================================

class LoginInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final bool showBorder;
  final Widget? suffix;

  const LoginInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.showBorder = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: showBorder
              ? const Color(0xFF111111)
              : Colors.transparent,
          width: 1.2,
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 15,
            offset: Offset(0, 7),
          ),
        ],
      ),

      padding: const EdgeInsets.symmetric(horizontal: 12),

      child: Row(
        children: [
          // Left icon
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF333333),
          ),

          const SizedBox(width: 11),

          // Label + text field
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF707070),
                  ),
                ),

                SizedBox(
                  height: 26,
                  child: TextField(
                    controller: controller,
                    obscureText: obscureText,

                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF111111),
                    ),

                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.only(top: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (suffix != null) ...[
            const SizedBox(width: 8),
            suffix!,
          ],
        ],
      ),
    );
  }
}


// =======================================================
// GOOGLE / APPLE BUTTON
// =======================================================

class SocialLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF111111),
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),

            boxShadow: const [
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),

          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),

                const SizedBox(width: 9),

                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}