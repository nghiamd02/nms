import 'dart:io';
import 'package:nms/screens/change_password_screen.dart';
import 'package:nms/screens/edit_profile_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:nms/helpers/account_helper.dart';
import 'package:nms/helpers/pref_helper.dart';
import '../Validator.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onSwitchForm;

  const SignInScreen({super.key, required this.onSwitchForm});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _rememberMe = false;
  bool passwordObsured = true;

  @override
  void initState() {
    super.initState();
    _loadRememberMeStatus();
  }

  _loadRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        PrefHelper.loadSavedCredentials(
            _passwordController, _passwordController);
        _login();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) => Validator.emailValidator(value),
              decoration: const InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: ' Enter your Email'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              obscureText: passwordObsured,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
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
            ListTile(
              title: const Text("Remember me"),
              leading: Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                    print(value);
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: const Text('Sign in')),
                ElevatedButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text('Exit'))
              ],
            )
          ],
        ));
  }

  _login() async {
    bool isLoginSuccess = false;
    final account = await SQLAccountHelper.getAccounts();
    for (var acc in account) {
      if (acc['email'] == _emailController.text &&
          acc['password'] == _passwordController.text) {
        isLoginSuccess = true;
        SQLAccountHelper.setCurrentAccount(_emailController);
        PrefHelper.saveCredentials(
            _rememberMe, _emailController, _passwordController);
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ChangePassWord()));
      }
    }
    !isLoginSuccess
        ? ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wrong username or password')))
        : null;
  }
}
