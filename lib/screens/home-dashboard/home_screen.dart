import 'package:flutter/material.dart';
import 'package:nms/models/account.dart';
import 'package:nms/screens/accounts/change_password_screen.dart';
import 'package:nms/screens/accounts/edit_profile_screen.dart';
import 'package:nms/screens/category-priority-status/category_screen.dart';
import 'package:nms/screens/home-dashboard/dashboard_screen.dart';
import 'package:nms/screens/notes/notes_screen.dart';
import 'package:nms/screens/category-priority-status/priority_screen.dart';
import 'package:nms/screens/home-dashboard/side_menu.dart';
import 'package:nms/screens/category-priority-status/status_screen.dart';

final _screens = [
  Dashboard(),
  CategoryScreen(),
  PriorityScreen(),
  StatusScreen(),
  NoteScreen(),
  EditProfile(),
  ChangePassWord(),
];

const _titles = [
  "Dashboard Screen",
  "Category Screen",
  "Priority Screen",
  "Status Screen",
  "Note Screen",
  'Edit Profile',
  'Change Password'
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
