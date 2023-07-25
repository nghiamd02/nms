import 'package:flutter/material.dart';
import 'package:nms/screens/notes_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return MaterialApp(
      title: 'Nms project',
      home: NoteScreen(),
    );
  }
}
