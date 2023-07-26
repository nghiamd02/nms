import 'package:flutter/material.dart';

import '../Validator.dart';
import '../helpers/SQLAccountHelper.dart';
import '../models/account.dart';

class SignUpScreen extends StatelessWidget {
  final VoidCallback onSwitchForm;

  SignUpScreen({required this.onSwitchForm});

  final _formKey = GlobalKey<FormState>();
  static final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

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
              obscureText: true,
              controller: _passwordController,
              validator: (value) => Validator.passwordValidator(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: ' Enter your Password',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              obscureText: true,
              controller: _confirmPasswordController,
              validator: (value) => Validator.confirmPasswordValidator(
                  value, _passwordController),
              decoration: const InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Confirm Password'),
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
                                'Register successful! Your information: \nEmail: ${_emailController.text}')));
                        _addAccount();
                        _emailController.text = '';
                        _passwordController.text = '';
                        _confirmPasswordController.text = '';
                      }
                    },
                    child: const Text('Sign up')),
                ElevatedButton(
                    onPressed: onSwitchForm, child: const Text('Sign In'))
              ],
            )
          ],
        ));
  }

  Future<void> _addAccount() async {
    await SQLAccountHelper.createAccount(Account(
      email: _emailController.text,
      password: _passwordController.text,
      // firstName: '',
      // lastName: '',
    ));
  }
}
