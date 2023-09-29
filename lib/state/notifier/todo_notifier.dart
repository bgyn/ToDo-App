import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/utils/database_helper.dart';

class ToDoNotifier extends StateNotifier<List<ToDo>> {
  List<ToDo>? todo;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  ToDoNotifier([this.todo]) : super(todo ?? <ToDo>[]) {
    _getToDoList();
  }

  Future<void> _getToDoList() async {
    state = await _databaseHelper.getTodoList();
  }

  Future<void> insert(ToDo todo) async {
    final result = await _databaseHelper.insertTodo(todo);
    if (result != 0) {
      state = await _databaseHelper.getTodoList();
    }
  }

  Future<void> update(ToDo todo) async {
    final result = await _databaseHelper.updateTodo(todo);
    if (result != 0) {
      state = await _databaseHelper.getTodoList();
    }
  }

  Future<void> delete(ToDo todo) async {
    final result = await _databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      state = await _databaseHelper.getTodoList();
    }
  }
}
