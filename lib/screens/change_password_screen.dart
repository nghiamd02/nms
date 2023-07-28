import 'package:flutter/material.dart';
import 'package:nms/screens/HomePage.dart';
import 'package:nms/screens/switch_screen.dart';
import '../Validator.dart';
import '../helpers/account_helper.dart';
import '../models/account.dart';

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

  bool passwordObsured = true;
  bool confirmpasswordObsured = true;
  late String password;
  double strengh = 0;
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

  bool _CurrentPassObscure = true;

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
              const Text(
                'Change password',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: _CurrentPassObscure,
                controller: _currentPassController,
                validator: (value) =>
                    Validator.CheckCurrentPasswordValidator(value),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Current password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _CurrentPassObscure = !_CurrentPassObscure;
                          });
                        },
                        icon: Icon(
                          _CurrentPassObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: passwordObsured,
                onChanged: (val) => checkPassword(val),
                controller: _newPassController,
                validator: (value) => Validator.confirmPasswordValidator(
                    value, _newPassController),
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
                height: 20,
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
                controller: _confirmnewPassController,
                validator: (value) => Validator.confirmPasswordValidator(
                    value, _newPassController),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'New password',
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
