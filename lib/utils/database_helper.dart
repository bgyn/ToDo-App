import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  //database attribute
  final String todoTable = 'todo_table';
  final String colId = 'id';
  final String colDescription = 'description';
  final String colIsComplete = 'isComplete';
  final String _colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  //get datbase
  Future<Database> get getDatabase async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    //get the directory from both the ios and android
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}todo.db';

    //create/open database at given path
    final todoDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  //create Database
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $todoTable($colId TEXT PRIMARY KEY ,$colDescription TEXT,$colIsComplete TEXT,$_colDate TEXT)');
  }

  //fetch operationj
  Future<List<Map<String, dynamic>>> getToDoMapList() async {
    Database db = await getDatabase;
    final result = await db.query(
      todoTable,
    );
    return result;
  }

  //insert operation
  Future<int> insertTodo(ToDo todo) async {
    Database db = await getDatabase;
    final result = await db.insert(todoTable, todo.toMap());
    return result;
  }

  //update operation
  Future<int> updateTodo(ToDo todo) async {
    Database db = await getDatabase;
    final result = await db.update(todoTable, todo.toMap(),
        where: '$colId = ?', whereArgs: [todo.getId()]);
    return result;
  }

  //delete operation
  Future<int> deleteTodo(int? id) async {
    Database db = await getDatabase;
    final result =
        await db.rawDelete('DELETE FROM $todoTable where $colId = $id');
    return result;
  }

  //get count
  Future<int> getCount() async {
    Database db = await getDatabase;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $todoTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  //get map list from database and conver it to todo oject
  Future<List<ToDo>> getTodoList() async {
    final todoMapList = await getToDoMapList();
    int count = await getCount();
    List<ToDo> todoList = List<ToDo>.empty(growable: true);
    for (int i = 0; i < count; i++) {
      todoList.add(ToDo.fromMapObject(todoMapList[i]));
    }
    return todoList;
  }
}
