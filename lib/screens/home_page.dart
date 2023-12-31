import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/state/notifier/todo_notifier.dart';
import 'package:todo_app/theme/provider/app_theme_provider.dart';
import 'package:todo_app/widget/show_dialog.dart';
import 'package:todo_app/widget/status_filter.dart';
import 'package:todo_app/widget/todo_list.dart';

enum TodoStatus {
  all,
  completed,
  notCompleted,
}

final todoStatusProvider = StateProvider<TodoStatus>((_) => TodoStatus.all);

final allTodoProvider =
    StateNotifierProvider<ToDoNotifier, List<ToDo>>((_) => ToDoNotifier());

final completedToDoProvider = Provider<Iterable<ToDo>>(
    (ref) => ref.watch(allTodoProvider).where((todo) => todo.isComplete!));

final notCompletedToDoProvider = Provider<Iterable<ToDo>>((ref) =>
    ref.watch(allTodoProvider).where((todo) => todo.isComplete! == false));

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(appThemeProvider);
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text("Theme"),
                trailing: Switch(
                    activeColor: Colors.grey,
                    value: isDarkMode,
                    onChanged: (_) {
                      ref.watch(appThemeProvider.notifier).changeTheme();
                    }),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "ToDo",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
        ),
        // backgroundColor: Colors.deepOrange,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const StatusFilter(),
              Consumer(
                builder: (context, ref, child) {
                  ref.watch(todoStatusProvider);
                  final filter = ref.read(todoStatusProvider);
                  switch (filter) {
                    case TodoStatus.all:
                      return ToDoList(provider: allTodoProvider);
                    case TodoStatus.completed:
                      return ToDoList(provider: completedToDoProvider);
                    case TodoStatus.notCompleted:
                      return ToDoList(provider: notCompletedToDoProvider);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: () async {
            final todo = await createOrEditToDO(context,'Create Todo');
            if (todo != null) {
              ref.watch(allTodoProvider.notifier).insert(todo);
            }
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
