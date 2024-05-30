import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../Providers/RegistrationProviders.dart';
import 'LoginPage.dart';
import 'package:faculty_review/constants.dart';
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends ConsumerState<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController erpController;

  @override
  void initState() {
    super.initState();
    emailController = ref.read(emailControllerProvider);
    passwordController = ref.read(passwordControllerProvider);
    confirmPasswordController = ref.read(confirmPasswordControllerProvider);
    firstNameController = ref.read(firstNameControllerProvider);
    lastNameController = ref.read(lastNameControllerProvider);
    erpController = ref.read(erpControllerProvider);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    erpController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    ref.read(obscureTextProvider.notifier).state = !ref.read(obscureTextProvider);
  }

  void registerUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      ref.read(errorMessageProvider.notifier).state = "Passwords do not match";
      return;
    }

    ref.watch(submissionStateProvider.notifier).state = SubmissionState.submitting;
    final uri = Uri.parse('$baseUrl/api/users/register');
    print(uri.toString());

    try {
      var dioInstance = Dio();
      final response = await dioInstance.post(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
          "firstname": firstNameController.text,
          "lastname": lastNameController.text,
          "erp": erpController.text  // Include ERP from user input
        }),
      );

      if (mounted) {
        if (response.statusCode == 200) {
          ref.read(submissionStateProvider.notifier).state = SubmissionState.success;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          ref.read(submissionStateProvider.notifier).state = SubmissionState.error;
          ref.read(errorMessageProvider.notifier).state = "Failed to register: ${response.data['msg']}";
          print(response.data['msg']);
        }
      }
    } catch (e) {
      if (mounted) {
        ref.read(submissionStateProvider.notifier).state = SubmissionState.error;
        ref.read(errorMessageProvider.notifier).state = "Failed to connect to the server: ${e.toString()}";
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final obscureText = ref.watch(obscureTextProvider);
    final errorMessage = ref.watch(errorMessageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: erpController,
              decoration: const InputDecoration(labelText: 'ERP'),
            ),
            TextField(
              controller: passwordController,
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(errorMessage, style: const TextStyle(color: Colors.red, fontSize: 14)),
              ),
            ElevatedButton(
              onPressed: registerUser,
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                'Already Registered? Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
