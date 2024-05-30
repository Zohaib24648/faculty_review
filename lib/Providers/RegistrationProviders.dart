// RegistrationProviders.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

final emailControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final passwordControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final confirmPasswordControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final firstNameControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final lastNameControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final erpControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());


final obscureTextProvider = StateProvider<bool>((ref) => true);
final errorMessageProvider = StateProvider<String>((ref) => "");

final formValidationProvider = StateProvider.autoDispose<Map<String, String?>>((ref) => {});
final registrationProgressProvider = StateProvider<double>((ref) => 0.0);
final userDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final submissionStateProvider = StateProvider<SubmissionState>((ref) => SubmissionState.idle);

enum SubmissionState {
  idle,
  submitting,
  success,
  error
}

final emailUniqueCheckProvider = FutureProvider.family<bool, String>((ref, email) async {
  return true; // Placeholder for actual check
});
