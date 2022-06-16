import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../db/TodoDatabase.dart';

class GeneralProvider extends ChangeNotifier {
  List<Todo> todos = [];

  Future<void> getTodos() async {
    todos = await TodoDatabase.instance.readallTodos();
    notifyListeners();
  }

  DateTime date = DateTime.now();

  List<Todo> get getTodo {
    return todos;
  }

  Future<void> addTodo(Todo newTodo) async {
    todos.add(newTodo);
    await TodoDatabase.instance.create(newTodo);
    notifyListeners();
  }

  Future<void> removeTodo(int index, Todo todo) async {
    todos.removeAt(index);
    await TodoDatabase.instance.delete(todo.id as int);
    notifyListeners();
  }
}
