import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nms/models/category.dart';

import 'package:nms/models/note.dart';
import 'package:nms/models/priority.dart';
import 'package:nms/models/status.dart';
import 'package:nms/screens/note_details.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NoteScreenState();
  }
}

class _NoteScreenState extends State<NoteScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget _addingDialog() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text('Enter Note Name'),
            ),
          ),
          Row(
            children: [
              Text('adfadskf'),
              const Spacer(),
              DropdownButton(
                  items: ['Apple', 'Banana', 'Orange']
                      .map((element) =>
                      DropdownMenuItem(value: element, child: Text(element)))
                      .toList(),
                  onChanged: (value) {}),
            ],
          ),
          Row(
            children: [
              Text('adfkasf'),
              const Spacer(),
              ElevatedButton(onPressed: (){
                var now = DateTime.now();
                showDatePicker(context: context, initialDate: now, firstDate: DateTime(now.year - 1, now.month, now.day), lastDate: DateTime(now.year + 10, now.month, now.day));
              }, child: Text('...'), style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),),
            ],
          )
        ],
      ),
      actions: [
        TextButton(onPressed: (){}, child: Text('Add', style: TextStyle(color: Colors.grey),)),
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel', style: TextStyle(color: Colors.grey),)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return NoteDetails();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => _addingDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
