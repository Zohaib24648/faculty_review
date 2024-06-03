import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Screens/LoginPage.dart';
import 'Providers/token_notifier.dart';
import 'Screens/MainScree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenNotifier = ref.read(tokenProvider.notifier);

    return MaterialApp(
      // title: 'AcademiQ',
      // theme: ThemeData(
      //   primarySwatch: Colors.brown,
      // ),
      home: FutureBuilder(
        future: tokenNotifier.initialized,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            final token = ref.watch(tokenProvider);
            if (token != null) {
              return const MainScreen(); // Using MainScreen when logged in
            } else {
              return const LoginPage();
            }
          }
        },
      ),
    );
  }
}
