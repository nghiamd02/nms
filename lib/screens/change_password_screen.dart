import 'package:flutter/material.dart';

import '../Validator.dart';
import '../helpers/SQLAccountHelper.dart';
import '../models/account.dart';
import 'HomePage.dart';

class ChangePassWord extends StatefulWidget {
  const ChangePassWord({super.key});

  @override
  State<ChangePassWord> createState() => _ChangePassWordState();
}

class _ChangePassWordState extends State<ChangePassWord> {
  final _formkey = GlobalKey<FormState>();
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmnewPassController = TextEditingController();

  late bool _isCurrentPassObscure;
  late bool _isNewPassObscure;
  late bool _isConfirmPassObscure;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isCurrentPassObscure = true;
    _isNewPassObscure = true;
    _isConfirmPassObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.lock_open,
                    size: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Change your password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: _isCurrentPassObscure,
                controller: _currentPassController,
                validator: (value) => Validator.passwordValidator(value),
                decoration: const InputDecoration(
                  labelText: 'Current password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: _isNewPassObscure,
                controller: _newPassController,
                validator: (value) => Validator.confirmPasswordValidator(
                    value, _newPassController),
                decoration: const InputDecoration(
                  labelText: 'New password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: _isConfirmPassObscure,
                controller: _confirmnewPassController,
                validator: (value) => Validator.passwordValidator(value),
                decoration: const InputDecoration(
                  labelText: 'Confirm new password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          SQLAccountHelper.updateAccount(Account(
                              id: SQLAccountHelper.currentAccount['id'],
                              email: SQLAccountHelper.currentAccount['email'],
                              password: _newPassController.text));

                          print(SQLAccountHelper.currentAccount['id']);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Change successful! ')));
                      },
                      child: const Text('Change')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      },
                      child: const Text('Home'))
                ],
              ),
            ],
          )),
    ));
  }
}
