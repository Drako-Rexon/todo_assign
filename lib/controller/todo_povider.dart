import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoPovider extends ChangeNotifier {
  final List<Map<String, dynamic>> _todos = [];
  int num = 0;
  final String _allTodosKey = "allTodos";

  List<Map<String, dynamic>> get todos => _todos;

  void addTodo(Map<String, dynamic> data) async {
    final pref = await SharedPreferences.getInstance();

    _todos.add(data);
    await pref.setString(_allTodosKey, _todos.toString());
    log(_todos.toString());
    notifyListeners();
  }

  void getAllTodo() async {
    final pref = await SharedPreferences.getInstance();
    // _todos.clear();

    final jsonString = pref.get(_allTodosKey);
    if (jsonString != null) {
      _todos.addAll(List<Map<String, dynamic>>.from(jsonDecode(_allTodosKey)));
    }

    notifyListeners();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void updateTodo(int index, BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    // Get the title and description of the todo at the given index
    final todo = _todos[index];
    titleController.text = todo['title'];
    descriptionController.text = todo['description'];

    showModalBottomSheet(
      backgroundColor: Colors.grey,
      context: context,
      builder: (_) {
        return Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Title:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintText: 'Enter your Title',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color:
                            Colors.transparent), // No border when not focused
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.blue), // Border color when focused
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintText: 'Description',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color:
                            Colors.transparent), // No border when not focused
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.blue), // Border color when focused
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green)),
                    onPressed: () {
                      // Update the todo with the new title and description
                      _todos[index]['title'] = titleController.text;
                      _todos[index]['description'] = descriptionController.text;
                      notifyListeners();
                      Navigator.pop(context);
                    },
                    child: const Text('Update',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    notifyListeners();
  }

  void clear() {
    _todos.clear();
    notifyListeners();
  }
}
