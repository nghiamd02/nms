import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:nms/helpers/category_helper.dart';
import 'package:nms/helpers/note_helper.dart';
import 'package:nms/helpers/priority_helper.dart';
import 'package:nms/helpers/status_helper.dart';

import 'package:nms/models/note.dart';

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
    print('Refreshing..');
    final data = await NoteHelper.getNotes();

    setState(() {
      print('set state');
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    _refreshJournals();
  }

  Future<void> getData() async {
    _categories = await CategoryHelper.getCategories();
    _priorities = await PriorityHelper.getPriorities();
    _statusList = await StatusHelper.getStatusList();
    _categoryValue = _categories[0][columnCategoryTitle];
    _priorityValue = _priorities[0][columnPriorityTitle];
    _statusValue = _statusList[0][columnStatusTitle];
  }

  Widget _addingDialog({Map<String, dynamic>? currentNote}){
    if(currentNote != null){
      _nameController.text = currentNote[columnNoteName];
      _categoryValue = _categories.firstWhere((element) => element[columnCategoryId] == currentNote[columnCategory])[columnCategoryTitle];
      _priorityValue = _priorities.firstWhere((element) => element[columnPriorityId] == currentNote[columnPriority])[columnPriorityTitle];
      _statusValue = _statusList.firstWhere((element) => element[columnStatusId] == currentNote[columnStatus])[columnStatusTitle];
      _planDate = DateFormat('dd/MM/yyyy').parse(currentNote[columnPlanDate]);
    }


    return AlertDialog(
      content: StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text('Enter Note Name'),
              ),
              onChanged: (value) {
                _nameController.text = value;
              },
            ),
            Row(
              children: [
                const Text('Select category'),
                const Spacer(),
                DropdownButton<String>(
                  value: _categoryValue,
                  items: _categories
                      .map((e) =>
                      DropdownMenuItem<String>(
                        value: e[columnCategoryTitle],
                        child: Text(e[columnCategoryTitle]),
                      ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _categoryValue = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Select priority'),
                const Spacer(),
                DropdownButton<String>(
                  value: _priorityValue,
                  items: _priorities
                      .map((e) =>
                      DropdownMenuItem<String>(
                        value: e[columnPriorityTitle],
                        child: Text(e[columnPriorityTitle]),
                      ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _priorityValue = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Select status'),
                const Spacer(),
                DropdownButton<String>(
                  value: _statusValue,
                  items: _statusList
                      .map((e) =>
                      DropdownMenuItem<String>(
                        value: e[columnStatusTitle],
                        child: Text(e[columnStatusTitle]),
                      ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _statusValue = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(_planDate != null
                    ? DateFormat('dd/MM/yyyy').format(_planDate!)
                    : 'Select plan date'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    var now = DateTime.now();
                    var selectedDate = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(now.year - 1, now.month, now.day),
                        lastDate: DateTime(now.year + 10, now.month, now.day));
                    setState(() {
                      _planDate = selectedDate;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[200]),
                  child: const Text('...'),
                ),
              ],
            )
          ],
        );
      }),
      actions: [
        TextButton(
            onPressed: () async {
              if (currentNote == null) {
                await _addNote();
              }
              if (currentNote != null) {
                await _updateNote(currentNote[columnNoteId]);
              }

              _nameController.text = '';

              if (!mounted) return;
              Navigator.of(context).pop();
            },
            child: Text(
              currentNote == null ? 'Add' : 'Update',
            )),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Management'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.separated(
        separatorBuilder: (context, index) =>
        const SizedBox(
          height: 10,
        ),
        itemCount: _journals.length,
        itemBuilder: (context, index){
          return NoteDetails(
            index: index,
            notes: _journals,
            editDialog: _addingDialog,
            deleteNote: _deleteNote,
            currentNote: _journals[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return _addingDialog();
            }
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addNote() async {
    String noteName = _nameController.text;
    int catId = _categories.firstWhere((element) =>
    element[columnCategoryTitle] ==
        _categoryValue!.trim())[columnCategoryId];
    int priorityId = _priorities.firstWhere((element) =>
    element[columnPriorityTitle] == _priorityValue!)[columnPriorityId];
    int statusId = _statusList.firstWhere((element) =>
    element[columnStatusTitle] == _statusValue!)[columnStatusId];

    await NoteHelper.createNote(Note(
        name: noteName,
        category: catId,
        priority: priorityId,
        status: statusId,
        planDate: DateFormat('dd/MM/yyyy').format(_planDate!),
        createAt: getCurrentDateTime()));
    _refreshJournals();
  }

  Future<void> _updateNote(int id) async {
    await NoteHelper.updateNote(Note(
      id :id,
      name: _nameController.text,
      category: _categories.firstWhere((element) => element[columnCategoryTitle] == _categoryValue)[columnCategoryId],
      priority: _priorities.firstWhere((element) => element[columnPriorityTitle]  == _priorityValue)[columnPriorityId],
      status: _statusList.firstWhere((element) => element[columnStatusTitle ] == _statusValue)[columnStatusId],
      planDate: DateFormat('dd/MM/yyyy').format(_planDate!),
      createAt: getCurrentDateTime(),
    ));
    _refreshJournals();
  }

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
  const NoteDetails(
      {super.key, this.index, this.notes, required this.editDialog, required this.deleteNote, required this.currentNote});

  final int? index;
  final List<Map<String, dynamic>>? notes;
  final Widget Function({Map<String, dynamic> currentNote}) editDialog;
  final Future<void> Function(int id) deleteNote;
  final Map<String, dynamic> currentNote;



  @override
  Widget build(BuildContext context) {
    int noteId = notes![index!][columnNoteId];
    String noteName = notes![index!][columnNoteName];
    int noteCategory = notes![index!][columnCategory];
    int notePriority = notes![index!][columnPriority];
    int noteStatus = notes![index!][columnStatus];
    String notePlanDate = notes![index!][columnPlanDate];
    String noteCreateAt = notes![index!][columnCreateAt];


    return Card(
      color: Colors.orange[200],
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          noteName,
          style: const TextStyle(fontSize: 25),
        ),
        subtitle: Text(
          'Category: $noteCategory\nPriority: $notePriority\nStatus: $noteStatus\nPlan Date: $notePlanDate\nCreate Date: $noteCreateAt',
          style: const TextStyle(fontSize: 20),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(children: [
            IconButton(
                onPressed: () {
                  showDialog(context: context,
                      builder: (context) => editDialog(currentNote: currentNote));
                },
                icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {
              deleteNote(noteId);
            }, icon: const Icon(Icons.delete))
          ]),
        ),
      ),
    );
  }
}

String getCurrentDateTime() {
  return DateFormat('dd/MM/yyyy h:mm a').format(DateTime.now());
}
