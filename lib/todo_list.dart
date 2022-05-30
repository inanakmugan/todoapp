import 'package:flutter/material.dart';

import './todo.dart';

class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  List<Todo> todos = [];

  void toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isChanged = isChecked;
    });
  }

  TextEditingController controller = new TextEditingController();

  _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Todo'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  setState(() {
                    todos.add(Todo(title: controller.text, isChanged: false));
                  });
                  controller.clear();
                  Navigator.of(context).pop();
                },
                child: Text('Add')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel')),
          ],
        );
      },
    );
  }

  Widget _itembuild(BuildContext context, int index) {
    return CheckboxListTile(
      title: Text(todos[index].title),
      value: todos[index].isChanged,
      onChanged: (bool? value) {
        toggleTodo(todos[index], value as bool);
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemBuilder: _itembuild,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}
