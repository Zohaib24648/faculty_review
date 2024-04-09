import 'package:flutter/material.dart';

const Color brownColor = Color(0xff700f1a);

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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
