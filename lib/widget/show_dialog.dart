import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/model/date_time_model.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/theme/provider/app_theme_provider.dart';

final _descriptionController = TextEditingController();

Future<ToDo?> createOrEditToDO(BuildContext context, [ToDo? existingToDo]) {
  String? description = existingToDo?.description;
  _descriptionController.text = description ?? "";
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(builder: (context, ref, _) {
        final isDarkMode = ref.watch(appThemeProvider);
        return AlertDialog(
          backgroundColor:
              isDarkMode ? const Color.fromARGB(255, 41, 41, 41) : Colors.white,
          title: Text(
            "Create a ToDo",
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "Enter the description here....",
                ),
                onChanged: (value) => description = value,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                //cancel alert dialog
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (description != null) {
                  //updating existing todo
                  if (existingToDo != null) {
                    existingToDo.description = description;
                    final newToDo = existingToDo;
                    Navigator.of(context).pop(newToDo);
                  }
                  //creating new todo
                  else {
                    Navigator.of(context).pop(
                      ToDo(
                        description: description,
                        date: getDateTime(),
                      ),
                    );
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save"),
            )
          ],
        );
      });
    },
  );
}
