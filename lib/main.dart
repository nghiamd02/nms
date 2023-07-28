import 'package:flutter/material.dart';
import 'package:nms/screens/category_screen.dart';
import 'package:nms/screens/dashboard_screen.dart';
import 'package:nms/screens/notes_screen.dart';
import 'package:nms/screens/priority_screen.dart';
import 'package:nms/screens/side_menu.dart';
import 'package:nms/screens/status_screen.dart';

const _screens = [
  Dashboard(),
  CategoryScreen(),
  PriorityScreen(),
  StatusScreen(),
  NoteScreen(),
];

const _titles = [
  "Dashboard Screen",
  "Category Screen",
  "Priority Screen",
  "Status Screen",
  "Note Screen",
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nms project',
        home: Scaffold(
          drawer: SideMenu((index) {
            setState(() {
              _currentPage = index;
            });
          }),
          appBar: AppBar(
            title: Text(_titles[_currentPage] ?? ""),
          ),
          body: _screens[_currentPage],
        ));
  }
}
