import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:nms/helpers/account_helper.dart';
import 'package:nms/helpers/category_helper.dart';
import 'package:nms/helpers/note_helper.dart';
import 'package:nms/helpers/priority_helper.dart';
import 'package:nms/helpers/status_helper.dart';
import 'package:nms/models/account.dart';

import 'package:nms/models/note.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({super.key});

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
  late Account _currentAccount;

  bool _isLoading = true;
  final TextEditingController _nameController = TextEditingController();
  String? _categoryValue;
  String? _priorityValue;
  String? _statusValue;
  DateTime? _planDate;

  List<Map<String, dynamic>> filterNotes(){
      return _journals.where((element) => Note.fromJson(element).accountId == _currentAccount.id).toList();
  }

  Future<void> _refreshJournals() async {
    final data = await NoteHelper.getNotes();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentAccount = Account.fromJson(SQLAccountHelper.currentAccount);
    print(_currentAccount.email);
    _getData();
  }

  Future<void> _getData() async {
    final categoriesData = await CategoryHelper.getCategories();
    final prioritiesData = await PriorityHelper.getPriorities();
    final statusData = await StatusHelper.getStatusList();

    setState(() {
      _categories = categoriesData;
      _priorities = prioritiesData;
      _statusList = statusData;

      if (_categories.isNotEmpty) {
        _categoryValue = _categories[0][columnCategoryName];
      }
      if (_priorities.isNotEmpty) {
        _priorityValue = _priorities[0][columnPriorityName];
      }
      if (_statusList.isNotEmpty) {
        _statusValue = _statusList[0][columnStatusName];
      }
    });
    _refreshJournals();
  }

  Widget _addingDialog({Map<String, dynamic>? currentNote}) {
    if (currentNote != null) {
      _nameController.text = currentNote[columnNoteName];
      _categoryValue = _categories.firstWhere((element) =>
          element[columnCategoryId] ==
          currentNote[columnCategory])[columnCategoryName];
      _priorityValue = _priorities.firstWhere((element) =>
          element[columnPriorityId] ==
          currentNote[columnPriority])[columnPriorityName];
      _statusValue = _statusList.firstWhere((element) =>
          element[columnStatusId] ==
          currentNote[columnStatus])[columnStatusName];
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
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('Enter Note Name'),
              ),
            ),
            Row(
              children: [
                const Text('Select category'),
                const Spacer(),
                DropdownButton<String>(
                  value: _categoryValue,
                  items: _categories
                      .map((e) => DropdownMenuItem<String>(
                            value: e[columnCategoryName],
                            child: Text(e[columnCategoryName]),
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
                      .map((e) => DropdownMenuItem<String>(
                            value: e[columnPriorityName],
                            child: Text(e[columnPriorityName]),
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
                      .map((e) => DropdownMenuItem<String>(
                            value: e[columnStatusName],
                            child: Text(e[columnStatusName]),
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
              _planDate = null;

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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: filterNotes().length,
              itemBuilder: (context, index) {
                return NoteDetails(
                  index: index,
                  notes: _journals,
                  editDialog: _addingDialog,
                  deleteNote: _deleteNote,
                  currentNote: _journals[index],
                  categories: _categories,
                  priorities: _priorities,
                  statusList: _statusList,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return _addingDialog();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addNote() async {
    String noteName = _nameController.text;
    int catId = _categories.firstWhere((element) =>
        element[columnCategoryName] ==
        _categoryValue!.trim())[columnCategoryId];
    int priorityId = _priorities.firstWhere((element) =>
        element[columnPriorityName] == _priorityValue!)[columnPriorityId];
    int statusId = _statusList.firstWhere((element) =>
        element[columnStatusName] == _statusValue!)[columnStatusId];

    await NoteHelper.createNote(Note(
        name: noteName,
        category: catId,
        priority: priorityId,
        status: statusId,
        planDate: DateFormat('dd/MM/yyyy').format(_planDate!),
        accountId: _currentAccount.id,
        createAt: getCurrentDateTime()));
    _refreshJournals();
  }

  Future<void> _updateNote(int id) async {
    await NoteHelper.updateNote(Note(
      id: id,
      name: _nameController.text,
      category: _categories.firstWhere((element) =>
          element[columnCategoryName] == _categoryValue)[columnCategoryId],
      priority: _priorities.firstWhere((element) =>
          element[columnPriorityName] == _priorityValue)[columnPriorityId],
      status: _statusList.firstWhere((element) =>
          element[columnStatusName] == _statusValue)[columnStatusId],
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
      {super.key,
      required this.index,
      required this.notes,
      required this.editDialog,
      required this.deleteNote,
      required this.currentNote,
      required this.categories,
      required this.priorities,
      required this.statusList});

  final int index;
  final List<Map<String, dynamic>> notes;
  final Widget Function({Map<String, dynamic> currentNote}) editDialog;
  final Future<void> Function(int id) deleteNote;
  final Map<String, dynamic> currentNote;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> priorities;
  final List<Map<String, dynamic>> statusList;

  @override
  Widget build(BuildContext context) {
    Note? nowNote = Note.fromJson(currentNote);
    String noteCategory = categories.firstWhere((element) =>
        element[columnCategoryId] == nowNote.category)[columnCategoryName];
    String notePriority = priorities.firstWhere((element) =>
        element[columnPriorityId] == nowNote.priority)[columnPriorityName];
    String noteStatus = statusList.firstWhere((element) =>
        element[columnStatusId] == nowNote.status)[columnStatusName];

    return Card(
      color: Colors.orange[200],
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          nowNote.name!,
          style: const TextStyle(fontSize: 25),
        ),
        subtitle: Text(
          'Category: $noteCategory\nPriority: $notePriority\nStatus: $noteStatus\nPlan Date: ${nowNote.planDate}\nCreate Date: ${nowNote.createAt}',
          style: const TextStyle(fontSize: 20),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(children: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          editDialog(currentNote: currentNote));
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  deleteNote(nowNote.id!);
                },
                icon: const Icon(Icons.delete))
          ]),
        ),
      ),
    );
  }
}

String getCurrentDateTime() {
  return DateFormat('dd/MM/yyyy h:mm a').format(DateTime.now());
}
