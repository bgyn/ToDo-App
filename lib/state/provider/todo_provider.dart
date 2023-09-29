import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/state/notifier/todo_notifier.dart';

final todoProvider = StateNotifierProvider<ToDoNotifier,List<ToDo>>((ref) => ToDoNotifier());
