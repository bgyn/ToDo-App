import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final descriptionController = TextEditingController();

Future<ToDo?> createOrEditToDO(BuildContext context, [ToDo? existingToDo]) {
  String? description = existingToDo?.description;
  descriptionController.text = description ?? "";
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Create a ToDo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                label: Text("Enter the description here......."),
              ),
              onChanged: (value) => description = value,
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (description != null) {
                //updating existing todo
                if (existingToDo != null) {
                  final newToDo = existingToDo.update(description: description);
                  Navigator.of(context).pop(newToDo);
                }
                //creating new todo
                else {
                  Navigator.of(context).pop(ToDo(
                    id: _uuid.v4(),
                    description: description!,
                  ));
                }
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text("Save"),
          )
        ],
      );
    },
  );
}
