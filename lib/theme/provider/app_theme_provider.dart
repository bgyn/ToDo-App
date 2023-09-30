import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeNotifer extends StateNotifier<bool> {
  final ThemeLocalStorage _themeLocalStorage = ThemeLocalStorage();
  bool? isDarkTheme;
  AppThemeNotifer([isDarkTheme]) : super(isDarkTheme ?? false) {
    initializeTheme();
  }

  Future<void> initializeTheme() async {
    isDarkTheme = await _themeLocalStorage.getTheme();
    state = isDarkTheme!;
  }

  void changeTheme() async {
    await _themeLocalStorage.setTheme(!state);
    state = !state;
  }
}

final appThemeProvider =
    StateNotifierProvider<AppThemeNotifer, bool>((_) => AppThemeNotifer());

class ThemeLocalStorage {
  Future<bool> getTheme() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('isdark') ?? false;
  }

  Future<void> setTheme(bool isDark) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isdark', isDark);
  }
}
