import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appbar = AppBar(
    toolbarHeight: 100,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purpleAccent, Colors.purple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Todo List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '2 Haz.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    ),

    //title: Text('Todo List'),
    //centerTitle: true,
  );

  @override
  Widget build(BuildContext context) {
    return appbar;
  }

  @override
  Size get preferredSize => Size.fromHeight(appbar.preferredSize.height);
}
