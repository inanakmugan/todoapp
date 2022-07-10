import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize {
    return new Size.fromHeight(100);
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  late AppBar appbar;

  static late String formattedDate;

  @override
  void initState() {
    formattedDate = DateFormat.MMMd().format(DateTime.now());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    appbar = AppBar(
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
              formattedDate,
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
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return appbar;
  }
}
