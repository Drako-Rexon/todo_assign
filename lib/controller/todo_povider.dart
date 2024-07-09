import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/todo_model.dart';

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
    _todos.clear();

    _todos.addAll(List<Map<String, dynamic>>.from());
    notifyListeners();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void updateTodo(int index, Todo todo) {
    // _todos[index] = todo;
    notifyListeners();
  }

  void clear() {
    _todos.clear();
    notifyListeners();
  }
}
