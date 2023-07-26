import 'package:flutter/material.dart';
import 'package:nms/screens/side_menu.dart';
import 'package:nms/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class  MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nms project',
      home: Scaffold(
        drawer: const SideMenu(),
        body: const Center(
          child: Dashboard(),
        ),
      ),
    );
  }
}