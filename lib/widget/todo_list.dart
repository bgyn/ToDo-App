import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/widget/show_dialog.dart';

class ToDoList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<ToDo>> provdier;
  const ToDoList({super.key, required this.provdier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(provdier);
    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = todos.elementAt(index);
          return GestureDetector(onTap: () async {
            final updatedToDo = await createOrEditToDO(context, todo);
            if (updatedToDo != null) {
              ref.read(allTodoProvider.notifier).edit(updatedToDo);
            }
          }, child: Consumer(builder: ((context, ref, child) {
            ref.watch(allTodoProvider);
            return Dismissible(
              key: ValueKey(todo.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                ref.read(allTodoProvider.notifier).remove(todo);
              },
              child: ListTile(
                title: Text(todo.description),
                trailing: IconButton(
                  onPressed: () {
                    final isComplete = !todo.isComplete;
                    ref.read(allTodoProvider.notifier).update(todo, isComplete);
                  },
                  icon: todo.isComplete
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                ),
              ),
            );
          })));
        },
      ),
    );
  }
}
