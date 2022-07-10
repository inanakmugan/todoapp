import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';
import './CustomAppBar.dart';
import '../db/TodoDatabase.dart';

class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Todo> todos = [];
  bool isLoading = false;

  Database? db;

  @override
  void initState() {
    getDatabase();
    refreshTodos;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    refreshTodos();
    super.didChangeDependencies();
  }

  Future getDatabase() async {
    db = await TodoDatabase.instance.database;
  }

  Future refreshTodos() async {
    setState(() {
      isLoading = true;
    });
    todos = await TodoDatabase.instance.readallTodos().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isChanged = isChecked;
      TodoDatabase.instance.update(todo);
    });
  }

  TextEditingController controller = TextEditingController();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Todo'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  TodoDatabase.instance.create(Todo(
                    title: controller.value.text,
                    isChanged: false,
                    date: DateTime.now(),
                  ));
                  controller.clear();
                  Navigator.of(context).pop();
                  refreshTodos();
                },
                child: const Text('Add')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
          ],
        );
      },
    );
  }

  Widget _itembuild(BuildContext context, int index) {
    return isLoading
        ? CircularProgressIndicator()
        : Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 100,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: LinearGradient(
                colors: [Colors.yellow[700] as Color, Colors.redAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.clamp,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: todos[index].isChanged,
                  onChanged: (bool? value) {
                    toggleTodo(todos[index], value as bool);
                  },
                ),
                Text(
                  todos[index].title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    TodoDatabase.instance.delete(todos[index].id as int);
                    refreshTodos();
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.white70,
                )
              ],
            ),
          );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        itemBuilder: _itembuild,
        itemCount: todos.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}
