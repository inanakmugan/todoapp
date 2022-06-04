import 'package:flutter/material.dart';

import '../models/todo.dart';

class GeneralProvider extends ChangeNotifier {
  List<Todo> todos = [];
  DateTime date = DateTime.now();

  List<Todo> get getTodo {
    return todos;
  }

  addTodo(Todo newTodo) {
    todos.add(newTodo);
    notifyListeners();
  }

  removeTodo(int index) {
    todos.removeAt(index);
    notifyListeners();
  }
}
