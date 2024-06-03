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
  ValueNotifier<String?> passwordErrorNotifier = ValueNotifier(null);


  @override
  void initState() {
    super.initState();
    emailController = ref.read(emailControllerProvider);
    passwordController = ref.read(passwordControllerProvider);
    confirmPasswordController = ref.read(confirmPasswordControllerProvider);
    firstNameController = ref.read(firstNameControllerProvider);
    lastNameController = ref.read(lastNameControllerProvider);
    erpController = ref.read(erpControllerProvider);

    passwordController.addListener(checkPasswords);
    confirmPasswordController.addListener(checkPasswords);
  }

  void checkPasswords() {
    if (passwordController.text != confirmPasswordController.text) {
      passwordErrorNotifier.value = "Passwords do not match";
    } else {
      passwordErrorNotifier.value = null;
    }
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   firstNameController.dispose();
  //   lastNameController.dispose();
  //   erpController.dispose();
  //   passwordController.removeListener(checkPasswords);
  //   confirmPasswordController.removeListener(checkPasswords);
  //   passwordErrorNotifier.dispose();
  //   super.dispose();
  // }

  void togglePasswordVisibility() {
    ref.read(obscureTextProvider.notifier).state = !ref.read(obscureTextProvider);
  }

  void registerUser() async {
    if (passwordErrorNotifier.value != null) {
      return;
    }

    ref.watch(submissionStateProvider.notifier).state = SubmissionState.submitting;
    final uri = Uri.parse('$baseUrl/api/users/register');

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
          "erp": erpController.text
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
        }
      }
    } catch (e) {
      if (mounted) {
        ref.read(submissionStateProvider.notifier).state = SubmissionState.error;
        ref.read(errorMessageProvider.notifier).state = "Failed to connect to the server: ${e.toString()}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = ref.watch(errorMessageProvider);

    final obscureText = ref.watch(obscureTextProvider);

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
            ValueListenableBuilder<String?>(
              valueListenable: passwordErrorNotifier,
              builder: (context, value, child) {
                if (value != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(value, style: const TextStyle(color: Colors.red, fontSize: 14)),
                  );
                }
                return SizedBox.shrink();
              },
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
                child: Text(
                  'Please Check Your Email and Password',
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ElevatedButton(
              onPressed: () {
    ref.read(errorMessageProvider.notifier).state = ''; // Clear the error message
    registerUser(); // Attempt to register the user
    },
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
