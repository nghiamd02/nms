import 'package:flutter/material.dart';
import 'package:nms/helpers/SQLAccountHelper.dart';
import '../Validator.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = 'intro_screen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  late bool _checked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checked = false;
  }

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
                'NoteManagementSystem',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 100,
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
                    hintText: ' Enter your Password'),
              ),
              ListTile(
                title: const Text('Remember Me'),
                leading: Checkbox(
                    value: _checked,
                    onChanged: (value) {
                      setState(() {
                        _checked = value!;
                      });
                    }),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final account = await SQLAccountHelper.getAccounts();
                      account.forEach((acc) {
                        if (acc['email'] == _emailController.text &&
                            acc['password'] == _passwordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Login Successful')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Wrong username or password')));
                        }
                      });
                    }
                  },
                  child: const Text('Sign in'))
            ],
          )),
    );
  }
}
