import 'package:flutter/material.dart';
import 'package:nms/screens/HomePage.dart';
import 'package:nms/screens/switch_screen.dart';
import '../Validator.dart';
import '../helpers/sql_helper.dart';
import '../models/account.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit your profile',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  validator: (value) => Validator.nameValidator(value),
                  decoration: const InputDecoration(
                    hintText: 'First name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _lastNameController,
                  validator: (value) => Validator.nameValidator(value),
                  decoration: const InputDecoration(
                    hintText: 'Last name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) => Validator.nameValidator(value),
                  decoration: const InputDecoration(
                    hintText: ' Email',
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
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                email: _emailController.text,
                                id: SQLAccountHelper.currentAccount['id'],
                                password: SQLAccountHelper
                                    .currentAccount['password']));
                            SQLAccountHelper.setCurrentAccount(
                                _emailController);
                            print(SQLAccountHelper.currentAccount['id']);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Edit successful! ')));
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
      ),
    );
  }
}
