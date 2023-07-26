import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:nms/helpers/category_helper.dart';
import 'package:nms/helpers/note_helper.dart';
import 'package:nms/helpers/priority_helper.dart';
import 'package:nms/helpers/status_helper.dart';
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
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _priorities = [];
  List<Map<String, dynamic>> _statusList = [];
  bool _isLoading = true;
  final TextEditingController _nameController = TextEditingController();
  String? _categoryValue;
  String? _priorityValue;
  String? _statusValue;
  DateTime? _planDate;

  Future<void> _refreshJournals() async {
    final data = await NoteHelper.getNotes();

    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() async{
    super.initState();
    _categories = await CategoryHelper.getCategories();
    _priorities = await PriorityHelper.getPriorities();
    _statusList = await StatusHelper.getStatusList();
    _refreshJournals();
  }

  Widget _addingDialog() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              label: Text('Enter Note Name'),
            ),
          ),
          Row(
            children: [
              const Text('Select category'),
              const Spacer(),
              DropdownButton(
                  items: _categories
                      .map((element) => DropdownMenuItem(
                          value: element, child: Text(element[columnCategoryTitle])))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _categoryValue = value![columnCategoryTitle];
                    });
                  }),
            ],
          ),
          Row(
            children: [
              const Text('Select priorty'),
              const Spacer(),
              DropdownButton(
                  items: _priorities
                      .map((element) => DropdownMenuItem(
                      value: element, child: Text(element[columnPriorityTitle])))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _priorityValue = value![columnPriorityTitle];
                    });
                  }),
            ],
          ),
          Row(
            children: [
              const Text('Select status'),
              const Spacer(),
              DropdownButton(
                  value: _statusValue,
                  items: _statusList
                      .map((value) => DropdownMenuItem(
                      value: value, child: Text(value[columnStatusTitle])))
                      .toList(),
                  onChanged: (value){
                    setState(() {
                      // _statusValue = value![columnStatusTitle];
                    });
                  },),
            ],
          ),
          Row(
            children: [
              Text('Select plan date'),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  var now = DateTime.now();
                    _planDate = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(now.year - 1, now.month, now.day),
                      lastDate: DateTime(now.year + 10, now.month, now.day));
                },
                child: const Text('...'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[200]),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {

            },
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
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

  Future<void> _addNote() async {
    await NoteHelper.createNote(
      Note(name: _nameController.text, )
    );
    _refreshJournals();
  }

  // Future<void> _updateNote(int id) async {
  //   await NoteHelper.updateNote(
  //       Category(id: id, title: _nameController.text, createAt: getCurrentDateTime()));
  //
  //   _refreshJournals();
  // }

  Future<void> _deleteNote(int id) async {
    await NoteHelper.deleteNote(id);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a category!'),
    )); // SnackBar
    _refreshJournals();
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
        title: Text(
          'Name: Play Football',
          style: TextStyle(fontSize: 25),
        ),
        subtitle: Text(
          'Category: Sport\nPriority: Slow\nStatus: Done\nPlan Date: 123\nCreate Date: 3213',
          style: TextStyle(fontSize: 20),
        ),
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

  String getCurrentDateTime() {
    return DateFormat('dd/MM/yyyy h:mm a').format(DateTime.now());
  }
}
