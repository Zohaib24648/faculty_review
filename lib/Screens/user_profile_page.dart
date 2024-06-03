import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/providers/user_profile_provider.dart';
import 'package:faculty_review/Models/UserProfile.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue = ref.watch(userProfileProvider);

    return Scaffold(
      body: userProfileAsyncValue.when(
        data: (userProfile) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: userProfile.profilePicture.isEmpty
                            ? AssetImage('assets/images/Pedro.gif') as ImageProvider<Object>?
                            : NetworkImage(userProfile.profilePicture) as ImageProvider<Object>?,
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(thickness: 1.5),
                    SizedBox(height: 16),
                    Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(userProfile.email, style: TextStyle(fontSize: 16)),
                    SizedBox(height: 16),
                    Text('Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('${userProfile.firstname} ${userProfile.lastname}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 16),
                    // Text('ERP', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    // SizedBox(height: 4),
                    // SizedBox(height: 16),
                    Text('Roles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(userProfile.roles.join(', '), style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error', style: TextStyle(color: Colors.red))),
      ),
    );
  }
}
