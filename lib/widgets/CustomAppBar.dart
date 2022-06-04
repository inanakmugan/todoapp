import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  late DateTime newDate = DateTime.now();
  CustomAppBar({required this.newDate});

  AppBar myappbar = AppBar();

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize {
    return new Size.fromHeight(100);
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  void ChangeDate() {
    setState(() {
      formattedDate = DateFormat.MMMd().format(widget.newDate);
    });
  }

  static late String formattedDate;

  @override
  void initState() {
    formattedDate = DateFormat.MMMd().format(widget.newDate);
    widget.myappbar = AppBar(
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
    ;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.myappbar;
  }
}
