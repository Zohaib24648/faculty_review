import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/providers/user_profile_provider.dart';
import 'package:faculty_review/Models/UserProfile.dart';

class UserProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: userProfileAsyncValue.when(
        data: (userProfile) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: userProfile.profilePicture.isEmpty
                    ? AssetImage('assets/default_profile.png') as ImageProvider<Object>?
                    : NetworkImage(userProfile.profilePicture) as ImageProvider<Object>?,
              ),
              SizedBox(height: 16),
              Text('Email: ${userProfile.email}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Name: ${userProfile.firstname} ${userProfile.lastname}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('ERP: ${userProfile.erp}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Roles: ${userProfile.roles.join(', ')}', style: TextStyle(fontSize: 18)),
              // Add more fields as needed
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
