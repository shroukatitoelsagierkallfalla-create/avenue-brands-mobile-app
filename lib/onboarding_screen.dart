import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // PageController is responsible for moving between the 3 pages.
  final PageController _controller = PageController();

  // Keeps track of which onboarding page the user is currently on.
  int _page = 0;

  // All the content of the onboarding screens is stored here.
  // This lets us use one layout for all 3 pages instead of repeating code.
  final pages = [
    {
      'image': 'assets/images/onbd1.png',
      'title': 'All Your Favorite Brands',
      'text':
          'Discover your favorite brands and shop everything you love in one place',
    },
    {
      'image': 'assets/images/onbd2.png',
      'title': 'Discover Your Style',
      'text': 'Explore new looks and find pieces that match your style',
    },
    {
      'image': 'assets/images/onbd3.png',
      'title': 'Your Style, One Place',
      'text': 'Find, compare, and shop your favorite pieces with ease',
    },
  ];

  // When the user presses Next:
  // - go to the next page
  // - if it is the last page, open Login instead
  void next() {
    if (_page < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      login();
    }
  }

  // Opens the Login screen and replaces the onboarding screen.
  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // SafeArea prevents the UI from going under the status bar.
      body: SafeArea(
        child: Center(
          // FittedBox makes the whole design scale automatically
          // when the screen size changes.
          child: FittedBox(
            fit: BoxFit.contain,

            // This is the original Figma design size.
            // We build the UI using this fixed design size,
            // then FittedBox scales it for different screens.
            child: SizedBox(
              width: 440,
              height: 956,

              // PageView allows the user to swipe between the screens.
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,

                // Save the current page whenever the user swipes.
                onPageChanged: (page) {
                  setState(() {
                    _page = page;
                  });
                },

                // Builds the UI for each onboarding page.
                itemBuilder: (context, index) {
                  // Get the image, title and text for this page.
                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 54),

                    // Column arranges the elements vertically.
                    child: Column(
                      children: [
                        // Top section: Logo + Skip button.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 110,
                              height: 58,
                            ),

                            // Skip is only displayed on the first 2 pages.
                            if (index < 2)
                              OutlinedButton(
                                onPressed: login,
                                style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                  ),
                                ),
                                child: const Text(
                                  'SKIP',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF222222),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 35),

                        // Main image from the assets folder.
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            page['image']!,
                            width: 392,
                            height: 350,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 35),

                        // Title of the current onboarding page.
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF222222),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Short description under the title.
                        Text(
                          page['text']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Color(0xFF666666),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // These 3 dots show the user's current page.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (i) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                // The current page gets a dark dot.
                                color: i == _page
                                    ? const Color(0xFF222222)
                                    : const Color(0xFFD9D9D9),
                              ),
                            ),
                          ),
                        ),

                        // Takes the remaining space and pushes
                        // the button to the bottom.
                        const Spacer(),

                        // Next button.
                        // On the last page it becomes Get Started.
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: next,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF111111),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              index == 2 ? 'Get Started →' : 'Next →',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dispose the controller when the screen is removed
  // to release its resources.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
