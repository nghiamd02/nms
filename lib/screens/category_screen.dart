import 'package:flutter/material.dart';
import 'package:nms/models/category.dart';
import 'package:nms/helpers/category_helper.dart';
import 'package:intl/intl.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
    final data = await CategoryHelper.getCategories();

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
                        const InputDecoration(hintText: 'Category Form'),
                  ), // TextFormField
                  const SizedBox(
                    height: 10,
                  ), // SizedBox
                  // SizedBox

                  ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await _addCategory();
                      }

                      if (id != null) {
                        await _updateCategory(id);
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

  Future<void> _addCategory() async {
    final rs = await CategoryHelper.createCategory(
        Category(
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

  Future<void> _updateCategory(int id) async {
    final rs =  CategoryHelper.updateCategory(
        Category(id: id, name: _nameController.text, date: getCurrentDateTime())
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

  Future<void> _deleteCategory(int id) async {
    await CategoryHelper.deleteCategory(id);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a category!'),
    )); // SnackBar
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Form'),
      ), // AppBar

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
                                _deleteCategory(_journals[index]['id']),
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
