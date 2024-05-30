import 'package:flutter/material.dart';

const Color brownColor = Color(0xff700f1a);
const String baseUrl = 'http://172.15.90.187:3001';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      // Add other AppBar properties if needed
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
