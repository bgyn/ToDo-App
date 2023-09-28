import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/extension/capitalize.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/theme/provider/app_theme_provider.dart';

class StatusFilter extends StatelessWidget {
  const StatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final isDarkMode = ref.watch(appThemeProvider);
      return DropdownButton(
        padding: const EdgeInsets.all(5),
        dropdownColor:
            isDarkMode ? const Color.fromARGB(255, 41, 41, 41) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        value: ref.watch(todoStatusProvider),
        items: TodoStatus.values
            .map(
              (tds) => DropdownMenuItem(
                value: tds,
                child: Text(tds.toString().split('.').last.toCapitalize()),
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
