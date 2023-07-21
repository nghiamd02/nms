import 'package:flutter/material.dart';
import 'package:nms/screens/category_screen.dart';
import 'package:nms/screens/priority_screen.dart';
import 'package:nms/screens/status_screen.dart';
import 'package:nms/screens/notes.dart';
import 'package:nms/screens/dashboard.dart';


void main() {
  runApp(const StatusScreen());
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return const MaterialApp(
      title: 'Nms project',
      home: Scaffold(
        body: Center(
          child: Dashboard(),
        ),
      ),
    );
  }
}

class AppBarParams {
  final Widget title;
  final Color backgroundColor;

  AppBarParams({
    required this.title,
    required this.backgroundColor,
  });
}
