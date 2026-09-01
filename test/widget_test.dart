import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_avenue/main.dart';
import 'package:flutter_avenue/onboarding_screen.dart';

void main() {
  testWidgets('Avenue starts on onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(const AvenueApp());
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
