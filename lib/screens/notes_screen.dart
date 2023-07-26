import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nms/models/category.dart';

import 'package:nms/models/note.dart';
import 'package:nms/models/priority.dart';
import 'package:nms/models/status.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NoteScreenState();
  }
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ = TextEditingController();

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
                      .map((element) => DropdownMenuItem(
                      value: element, child: Text(element)))
                      .toList(),
                  onChanged: (value) {}),
            ],
          ),
          Row(
            children: [
              Text('adfkasf'),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  var now = DateTime.now();
                  var planDate = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(now.year - 1, now.month, now.day),
                      lastDate: DateTime(now.year + 10, now.month, now.day));
                },
                child: const Text('...'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[200]),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {},
            child: Text(
              'Add',
            )),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
            )),
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

class NoteDetails extends StatelessWidget {
  const NoteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // TextStyle textStyle = TextStyle(fontSize: 20, color: Colors.white);
    // return Card(
    //   color: Colors.orange[200],
    //   margin: EdgeInsets.all(15),
    //   child: Padding(
    //     padding: EdgeInsets.all(10),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Column(
    //           children: [
    //             Text(
    //               'Name: abcvdasf',
    //               style: textStyle,
    //             ),
    //             Text(
    //               'Priority: dsfaj',
    //               style: textStyle,
    //             ),
    //             Text(
    //               'Status: dsafdf',
    //               style: textStyle,
    //             ),
    //           ],
    //         ),
    //         Column(
    //           children: [
    //             Text(
    //               'Plan Date: 2142',
    //               style: textStyle,
    //             ),
    //             Text(
    //               'Create Date: 12313',
    //               style: textStyle,
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Card(
      color: Colors.orange[200],
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text('Name: Play Football', style: TextStyle(fontSize: 25),),
        subtitle: Text(
          'Category: Sport\nPriority: Slow\nStatus: Done\nPlan Date: 123\nCreate Date: 3213', style: TextStyle(fontSize: 20),),
        trailing: SizedBox(
          width: 100,
          child: Row(children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
          ]),
        ),
      ),
    );
  }
}