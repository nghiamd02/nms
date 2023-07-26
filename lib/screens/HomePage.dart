import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nms project',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NoteManagementSystem'),
        ),
        body: const Center(
          child: Text('Hello NMS'),
        ),
      ),
    );
  }
}
