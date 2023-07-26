import 'package:flutter/material.dart';
import 'package:nms/screens/notes_screen.dart';
import 'package:nms/screens/category_screen.dart';
import 'package:nms/screens/priority_screen.dart';
import 'package:nms/screens/status_screen.dart';
import 'package:nms/helpers/sql_helper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nms project',
      home: CategoryScreen(),
    );
  }
}
