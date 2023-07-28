import 'package:flutter/material.dart';

import '../Validator.dart';
import '../helpers/sql_helper.dart';
import '../models/account.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onSwitchForm;

  SignUpScreen({required this.onSwitchForm});

  static final _passwordController = TextEditingController();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _confirmPasswordController = TextEditingController();

  final _emailController = TextEditingController();
  bool passwordObsured = true;
  bool confirmpasswordObsured = true;
  late String password;
  double strengh = 0;
  bool isObscure = true;

  String text = "please enter a password";

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  void checkPassword(String value) {
    password = value.trim();
    if (password.isEmpty) {
      setState(() {
        strengh = 0;
        text = "please enter a password ";
      });
    } else if (password.length < 6) {
      setState(() {
        strengh = 1 / 4;
        text = "your password is too short";
      });
    } else if (password.length < 8) {
      setState(() {
        strengh = 2 / 4;
        text = " your password is acceptable but not strong";
      });
    } else {
      if (!letterReg.hasMatch(password) || !numReg.hasMatch(password)) {
        setState(() {
          strengh = 3 / 4;
          text = "your password is strong";
        });
      } else {
        setState(() {
          strengh = 1;
          text = "your password is great";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value) => Validator.emailValidator(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email), hintText: 'Enter your Email'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              obscureText: passwordObsured,
              onChanged: (val) => checkPassword(val),
              controller: SignUpScreen._passwordController,
              validator: (value) => Validator.passwordValidator(value),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'New password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordObsured = !passwordObsured;
                        });
                      },
                      icon: Icon(
                        passwordObsured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
            LinearProgressIndicator(
              value: strengh,
              backgroundColor: Colors.grey,
              color: strengh <= 1 / 4
                  ? Colors.red
                  : strengh == 2 / 4
                      ? Colors.yellow
                      : strengh == 3 / 4
                          ? Colors.blue
                          : Colors.green,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: confirmpasswordObsured,
              controller: _confirmPasswordController,
              validator: (value) => Validator.confirmPasswordValidator(
                  value, SignUpScreen._passwordController),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          confirmpasswordObsured = !confirmpasswordObsured;
                        });
                      },
                      icon: Icon(
                        confirmpasswordObsured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ))),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Signup successful! Your information: \nEmail: ${_emailController.text}')));
                        _addAccount();
                        _emailController.text = '';
                        SignUpScreen._passwordController.text = '';
                        _confirmPasswordController.text = '';
                      }
                    },
                    child: const Text('Sign up')),
                ElevatedButton(
                    onPressed: widget.onSwitchForm,
                    child: const Text('Sign In'))
              ],
            )
          ],
        ));
  }

  Future<void> _addAccount() async {
    await SQLAccountHelper.createAccount(Account(
      email: _emailController.text,
      password: SignUpScreen._passwordController.text,
      firstName: '',
      lastName: '',
    ));
  }
}
