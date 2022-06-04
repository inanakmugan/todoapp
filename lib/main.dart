import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/todo_list.dart';
import './providers/generalProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeneralProvider(),
      child: MaterialApp(
        home: ToDoList(),
      ),
    );
  }
}
