import 'package:flutter/material.dart';
import 'package:nms/models/priority.dart';
import 'package:nms/helpers/priority_helper.dart';
import 'package:intl/intl.dart';
import 'package:nms/screens/home-dashboard/side_menu.dart';

class PriorityScreen extends StatelessWidget {
  const PriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _HomePage(),
    ); // MaterialApp
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  Future<void> _refreshJournals() async {
    final data = await PriorityHelper.getPriorities();

    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  } // Loading the

// diary when the app starts
  final TextEditingController _nameController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _nameController.text = existingJournal['name'];
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ), // EdgeInsets.only
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                const InputDecoration(hintText: 'Priority Form'),
              ), // TextFormField
              const SizedBox(
                height: 10,
              ), // SizedBox
              // SizedBox

              ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addPriority();
                  }

                  if (id != null) {
                    await _updatePriority(id);
                  }

                  _nameController.text = '';

                  if (!mounted) return;
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Create New' : 'Update'),
              )
            ],
          ),
        ));
  }

  Future<void> _addPriority() async {
    bool rs = await PriorityHelper.createPriority(
      Priority(
          name: _nameController.text, date: getCurrentDateTime()),
    );

    if(rs == false) { // 2:error 1: success
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('ERROR: Name duplicated!'),
      ));
    }
    else {
      _refreshJournals();
    }
  }

  Future<void> _updatePriority(int id) async {
    final rs = await PriorityHelper.updatePriority(
        Priority(id: id, name: _nameController.text,date: getCurrentDateTime()));
    if(rs == false) { // 2:error 1: success
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('ERROR: Name duplicated!'),
      ));
    }
    else {
      _refreshJournals();
    }
  }

  Future<void> _deletePriority(int id) async {
    await PriorityHelper.deletePriority(id);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a priority!'),
    )); // SnackBar
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      ) // Center
          : ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) => Card(
          color: Colors.orange[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text("Name: ${_journals[index]['name']}"),
              subtitle: Text(getCurrentDateTime().toString()),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showForm(_journals[index]['id']),
                    ), // IconButton
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deletePriority(_journals[index]['id']),
                    ),
                  ],
                ),
              )),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ), // FloatingActionButton
    ); // Scaffold
  }
}

String getCurrentDateTime() {
  return DateFormat('dd/MM/yyyy h:mm a').format(DateTime.now());
}