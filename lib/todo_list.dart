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
    //   return CheckboxListTile(
    //     title: Text(todos[index].title),
    //     value: todos[index].isChanged,
    //     onChanged: (bool? value) {
    //       toggleTodo(todos[index], value as bool);
    //     },
    //   );
    // }

    return Container(
      padding: EdgeInsets.only(left: 15, right: 10),
      height: 100,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Yapılacak',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Checkbox(
            value: todos[index].isChanged,
            onChanged: (bool? value) {
              toggleTodo(todos[index], value as bool);
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          )
        ],
      ),
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
