import 'package:flutter/material.dart';

import '../Validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NoteManagementSystem'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Sign Up Form',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) => Validator.emailValidator(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter your Email'),
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                validator: (value) => Validator.passwordValidator(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: ' Enter your Password',
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: _confirmPasswordController,
                validator: (value) => Validator.passwordValidator(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: ' Enter your Password'),
              ),
            ],
          ),
        ));
  }
}
