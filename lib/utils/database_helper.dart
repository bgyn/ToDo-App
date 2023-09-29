import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  //database attribute
  final String _todoTable = 'todo_table';
  final String _colId = 'id';
  final String _colDescription = 'description';
  final String _colIsComplete = 'isComplete';
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
  //open/create database at given path

  //create Database
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $_todoTable($_colId INTEGER PRIMARY KEY AUTOINCREMENT ,$_colDescription TEXT,$_colIsComplete TEXT,$_colDate TEXT)');
  }

  //fetch operationj
  Future<List<Map<String, dynamic>>> getToDoMapList() async {
    Database db = await getDatabase;
    final result = await db.query(
      _todoTable,
    );
    return result;
  }

  //insert operation
  Future<int> insertTodo(ToDo todo) async {
    Database db = await getDatabase;
    final result = await db.insert(_todoTable, todo.toMap());
    return result;
  }

  //update operation
  Future<int> updateTodo(ToDo todo) async {
    Database db = await getDatabase;
    final result = await db.update(_todoTable, todo.toMap(),
        where: '$_colId = ? ', whereArgs: [todo.id]);
    return result;
  }

  //delete operation
  Future<int> deleteTodo(int? id) async {
    Database db = await getDatabase;
    final result =
        await db.rawDelete('DELETE FROM $_todoTable where $_colId = $id');
    return result;
  }

  //get count
  Future<int> getCount() async {
    Database db = await getDatabase;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $_todoTable');
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
