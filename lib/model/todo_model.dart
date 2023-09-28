import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/model/date_time_model.dart';
import 'package:uuid/uuid.dart';

@immutable
class ToDo {
  final String id;
  final String description;
  final String dateTime;
  final bool isComplete;
  ToDo({
    String? id,
    required this.description,
    this.isComplete = false,
    required this.dateTime,
  }) : id = id ?? const Uuid().v4();

  ToDo copy(bool isComplete) => ToDo(
      id: id,
      description: description,
      isComplete: isComplete,
      dateTime: dateTime);

  ToDo update({String? description, String? dateTime}) => ToDo(
        description: description ?? this.description,
        isComplete: isComplete,
        id: id,
        dateTime: dateTime ?? this.dateTime,
      );

  @override
  String toString() =>
      'ToDo(Description: $description,isComplete: $isComplete)';

  @override
  bool operator ==(covariant ToDo other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

//stateNotifier
class ToDoNotifier extends StateNotifier<List<ToDo>> {
  ToDoNotifier([List<ToDo>? todo]) : super(todo ?? []);

  //update if task is completed or not
  void update(ToDo todo, bool isComplete) {
    state = state
        .map((thisTodo) =>
            thisTodo.id == todo.id ? thisTodo.copy(isComplete) : thisTodo,)
        .toList();
  }

  //add new todo
  void add(ToDo todo) {
    state = [
      ...state,
      ToDo(
        // id: _uuid.v4(),
        description: todo.description,
        dateTime: getDateTime(),
      )
    ];
  }

  //editing existing todo
  void edit(ToDo updatedToDo) {
    state = [
      for (final todos in state)
        if (todos.id == updatedToDo.id)
          ToDo(
              description: updatedToDo.description,
              id: updatedToDo.id,
              dateTime: getDateTime())
        else
          todos,
    ];
  }

  //removing existing todo
  void remove(ToDo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }


}
