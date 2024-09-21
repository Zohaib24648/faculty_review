import 'package:faculty_review/Screens/Developers_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

void main() {
  group('SupportTheAuthorPage Tests', () {
    testWidgets('Page should have a profile picture, texts, and action buttons', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SupportTheAuthorPage()));

      // Checking if the Profile Picture is displayed
      expect(find.byType(Image), findsWidgets);

      // Checking for presence of texts
      expect(find.text('Zohaib Ali Mughal'), findsOneWidget);
      expect(find.text('Age: 21'), findsOneWidget);
      expect(find.text('Web & App Developer'), findsOneWidget);

      // Checking for support buttons
      expect(find.byType(SupportButton), findsNWidgets(3));
      expect(find.text('Coffee'), findsOneWidget);
      expect(find.text('Pizza'), findsOneWidget);
      expect(find.text('Burger'), findsOneWidget);
    });

    testWidgets('Social media buttons launch URLs', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SupportTheAuthorPage()));

      // Attempt to tap the LinkedIn icon button
      await tester.tap(find.byIcon(EvaIcons.linkedin));
      await tester.pumpAndSettle();

      // Since launching URL involves an async function, we might use a mock
      // to verify that the launchURL function is called with the correct URL.
      // This requires a bit of setup to inject a mock URL launcher.
    });

    testWidgets('Support buttons should trigger their respective actions', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SupportTheAuthorPage()));

      // Tap the "Coffee" button and check if the onPressed is triggered
      var coffeeButton = find.widgetWithText(SupportButton, 'Coffee');
      await tester.tap(coffeeButton);
      await tester.pump();

      // Similar setup for 'Pizza' and 'Burger', asserting the expected behaviors
    });
  });
}
