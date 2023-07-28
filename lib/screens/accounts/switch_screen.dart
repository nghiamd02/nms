import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'package:nms/screens/accounts/signup_screen.dart';

enum FormType { SignIn, SignUp }

class SwitchScreen extends StatefulWidget {
  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  FormType _currentForm = FormType.SignIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Note Management System'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  ' NoteManagementSystem',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  _currentForm == FormType.SignIn ? '' : '',
                  style: TextStyle(fontSize: 30),
                ),
                _buildForm(),
              ],
            ),
          ),
        ),
        floatingActionButton: _currentForm == FormType.SignIn
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _currentForm = _currentForm == FormType.SignIn
                        ? FormType.SignUp
                        : FormType.SignIn;
                  });
                },
                child: Icon(_currentForm == FormType.SignIn
                    ? Icons.person_add
                    : Icons.login),
              )
            : null);
  }

  Widget _buildForm() {
    if (_currentForm == FormType.SignIn) {
      return SignInScreen(onSwitchForm: _switchToSignUpForm);
    } else {
      return SignUpScreen(onSwitchForm: _switchToLoginForm);
    }
  }

  void _switchToSignUpForm() {
    setState(() {
      _currentForm = FormType.SignUp;
    });
  }

  void _switchToLoginForm() {
    setState(() {
      _currentForm = FormType.SignIn;
    });
  }
}
