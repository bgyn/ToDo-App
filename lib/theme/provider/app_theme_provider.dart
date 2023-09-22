import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppThemeNotifer extends StateNotifier<bool> {
  AppThemeNotifer([bool? isDarkTheme]) : super(isDarkTheme = false);

  void changeTheme() {
    state = !state;
  }
}

final appThemeProvider =
    StateNotifierProvider<AppThemeNotifer, bool>((_) => AppThemeNotifer());
