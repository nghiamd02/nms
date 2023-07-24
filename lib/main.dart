import 'package:flutter/material.dart';
import 'package:nms/screens/category_screen.dart';
import 'package:nms/screens/priority_screen.dart';
import 'package:nms/screens/status_screen.dart';
import 'package:nms/screens/notes.dart';


void main() {
  runApp(const StatusScreen());
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return MaterialApp(
      title: 'Nms project',
      home: NoteScreen(),
    );
  }
}
