import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:faculty_review/Screens/HomePage.dart';
import 'package:faculty_review/Screens/RegisterPage.dart';
import '../constants.dart';
import '../Providers/RegistrationProviders.dart';
import '../Providers/token_notifier.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUsernameController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final obscureText = ref.watch(obscureTextProvider);
    final errorMessage = ref.watch(errorMessageProvider);

    void togglePasswordVisibility() {
      ref.read(obscureTextProvider.notifier).state = !obscureText;
    }

    Future<void> loginUser() async {
      ref.read(submissionStateProvider.notifier).state = SubmissionState.submitting;
      final uri = Uri.parse('$baseUrl/api/users/login');

      print("Attempting to log in with URI: $uri");
      print("Username: ${loginUsernameController.text}, Password: ${passwordController.text}");

      try {
        var dioInstance = Dio();
        final response = await dioInstance.post(
          uri.toString(),
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: jsonEncode({
            "loginUsername": loginUsernameController.text,
            "password": passwordController.text,
          }),
        );

        print("Response status code: ${response.statusCode}");
        print("Response data: ${response.data}");

        if (response.statusCode == 200) {
          final token = response.data['token'];
          await ref.read(tokenProvider.notifier).setToken(token);
          ref.read(submissionStateProvider.notifier).state = SubmissionState.success;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          ref.read(submissionStateProvider.notifier).state = SubmissionState.error;
          ref.read(errorMessageProvider.notifier).state = "Failed to login: ${response.data['msg']}";
        }
      } catch (e) {
        print("Error: $e");
        ref.read(submissionStateProvider.notifier).state = SubmissionState.error;
        ref.read(errorMessageProvider.notifier).state = "Failed to connect to the server: ${e.toString()}";
      }
    }



    final deviceWidth = MediaQuery.of(context).size.width;
    final maxWidth = deviceWidth > 600 ? 600.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: const CustomAppBar(title: "AcademiQ"),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(
                        'assets/images/ibalogo.png',
                        width: deviceWidth > 600 ? 600 : deviceWidth * 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          controller: loginUsernameController,
                          decoration: const InputDecoration(
                            hintText: "Erp or Email",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: brownColor, width: 5),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.spaceMono().fontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "Enter your Password",
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: brownColor, width: 5),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                              onPressed: togglePasswordVisibility,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.spaceMono().fontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: loginUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff700f1a),
                                padding: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text(
                        'Register?',
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Dev by: Zohaib Mughal',
                style: TextStyle(
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xffffffff),
    );
  }
}
