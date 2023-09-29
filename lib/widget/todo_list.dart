import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/theme/provider/app_theme_provider.dart';
import 'package:todo_app/widget/show_dialog.dart';

class ToDoList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<ToDo>> provider;
  const ToDoList({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = todos.elementAt(index);
          return GestureDetector(
            onTap: () async {
              final updatedToDo = await createOrEditToDO(context, todo);
              if (updatedToDo != null) {
                ref.watch(allTodoProvider.notifier).update(updatedToDo);
              }
            },
            child: Consumer(
              builder: ((context, ref, child) {
                final isDarkMode = ref.watch(appThemeProvider);
                ref.watch(allTodoProvider);
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    ref.watch(allTodoProvider.notifier).delete(todo);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          todo.description!,
                          style: todo.isComplete!
                              ? Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 16,
                                  )
                              : Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    decoration: TextDecoration.none,
                                    fontSize: 16,
                                  ),
                        ),
                        subtitle: Text(
                          todo.date!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 12, color: Colors.grey.shade600),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            todo.isComplete = !todo.isComplete!;
                            ref.watch(allTodoProvider.notifier).update(todo);
                          },
                          icon: todo.isComplete!
                              ? Icon(
                                  Icons.check_box,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
