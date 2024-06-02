import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/Models/UserProfile.dart';
import 'package:faculty_review/Services/api_service.dart';
import 'package:faculty_review/Providers/token_notifier.dart';

final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final dio = ref.watch(dioProvider);
  final apiService = ApiService(dio);
  return await apiService.getUserProfile();
});