import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/theme/app_theme.dart';
import 'package:todo_app/theme/provider/app_theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: getAppTheme(context, ref.watch(appThemeProvider)),
      home: const HomePage(),
    );
  }
}
