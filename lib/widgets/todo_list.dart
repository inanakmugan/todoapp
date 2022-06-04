import 'package:flutter/material.dart';

import '../models/todo.dart';
import 'CustomAppBar.dart';

class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  List<Todo> todos = [];

  DateTime? newDate;

  @override
  void initState() {
    // TODO: implement initState
    newDate = DateTime.now();
  }

  void toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isChanged = isChecked;
    });
  }

  TextEditingController controller = new TextEditingController();

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
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
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
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                todos.removeAt(index);
              });
            },
            icon: Icon(Icons.delete),
            color: Colors.white70,
          )
        ],
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.purple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
              ),
              child: Container(
                height: 100,
              ),
            ),
            ListTile(
              title: Text(
                'Date',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onTap: () => pickDate(context),
            )
          ],
        ),
      ),
      appBar: CustomAppBar(newDate: newDate as DateTime),
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