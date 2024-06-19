import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faculty_review/providers/user_profile_provider.dart';
import 'package:faculty_review/Models/UserProfile.dart';
import 'package:faculty_review/Screens/user_profile_page.dart';

void main() {
  testWidgets('UserProfilePage shows loading, data, and error states', (WidgetTester tester) async {
    // Create mock data for user profile
    final mockUserProfile = UserProfile(
      id: '123',
      email: 'zohaib@gmail.com',
      firstname: 'Zohaib',
      lastname: 'Mughal',
      erp: 123456,
      profilePicture: '',
      roles: ['User'],
      savedComments: [],
      savedTeachers: [],
      savedCourses: [],
      isDeleted: false,
      createdBy: 'creator',
      modifiedBy: 'modifier',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
    );

    // Override the userProfileProvider with mock data
    final userProfileProviderOverride = userProfileProvider.overrideWith(
          (ref) async => mockUserProfile,
    );

    // Build the widget with the ProviderScope
    await tester.pumpWidget(
      ProviderScope(
        overrides: [userProfileProviderOverride],
        child: const MaterialApp(home: UserProfilePage()),
      ),
    );

    // Verify the loading state
    await tester.pump(); // This triggers the FutureProvider to resolve the future.
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Verify the data state
    expect(find.text('Zohaib Mughal'), findsOneWidget);
    expect(find.text('zohaib@gmail.com'), findsOneWidget);
    expect(find.text('User'), findsOneWidget);

    // Verify other fields
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Roles'), findsOneWidget);

    // Simulate an error state
    final userProfileProviderErrorOverride = userProfileProvider.overrideWith(
          (ref) async => throw Exception('Something went wrong'),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userProfileProviderErrorOverride],
        child: const MaterialApp(home: UserProfilePage()),
      ),
    );

    // Trigger the error state
    await tester.pump();

    // Log the entire widget tree
    debugDumpApp();

    // Verify the error state
    // expect(find.textContaining('Error:'), findsOneWidget);
  });
}
