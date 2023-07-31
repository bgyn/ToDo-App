import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/screens/home_page.dart';

class StatusFilter extends StatelessWidget {
  const StatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return DropdownButton(
        value: ref.watch(todoStatusProvider),
        items: TodoStatus.values
            .map(
              (tds) => DropdownMenuItem(
                value: tds,
                child: Text(tds.toString().split('.').last),
              ),
            )
            .toList(),
        onChanged: (tds) {
          ref
              .read(
                todoStatusProvider.notifier,
              )
              .state = tds!;
        },
      );
    });
  }
}
