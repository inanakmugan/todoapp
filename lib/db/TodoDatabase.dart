import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/todo.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    final String boolType = 'BOOLEAN NOT NULL';

    final String textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableTodos (
  ${Todofields.id} $idType,
  ${Todofields.title} $textType,
  ${Todofields.isChanged} $boolType,
  ${Todofields.date} $textType
)
''');
  }

  Future<Todo> create(Todo todo) async {
    final db = await instance.database;
    final id = await db.insert(
      tableTodos,
      todo.toJson(),
    );

    return todo.copy(id: id);
  }

  Future<Todo> readTodo(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTodos,
      columns: Todofields.values,
      where: '${Todofields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<Todo>> readallTodos() async {
    final db = await instance.database;

    final orderBy = '${Todofields.date} ASC';

    final result = await db.query(
      tableTodos,
      orderBy: orderBy,
    );
    return result.map((json) => Todo.fromJson(json)).toList();
  }

  Future<int> update(Todo todo) async {
    final db = await instance.database;

    return db.update(
      tableTodos,
      todo.toJson(),
      where: '${Todofields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableTodos,
      where: '${Todofields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
