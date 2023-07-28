import 'package:flutter/material.dart';
import 'package:nms/screens/change_password_screen.dart';
import 'package:nms/screens/edit_profile_screen.dart';
import 'package:nms/screens/switch_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwitchScreen(),
    );
  }
}
