import 'package:flutter/material.dart';
import 'package:nms/screens/SignInScreen.dart';
import 'package:nms/screens/SignUpScreen.dart';

void main() => runApp(const MyApp());

class  MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nms project',
      home: SignInScreen()
    );
  }
}