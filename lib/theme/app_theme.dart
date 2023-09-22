import 'package:flutter/material.dart';

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    primaryColorLight: const Color.fromRGBO(66, 133, 244, 1),
    primaryColorDark: const Color.fromRGBO(52, 168, 83, 1),
    extensions: const <ThemeExtension<AppColors>>[
      AppColors(
        color1: Color.fromRGBO(66, 133, 244, 1),
        color2: Color.fromRGBO(52, 168, 83, 1),
      )
    ],
    drawerTheme: DrawerThemeData(
      backgroundColor:
          isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
    ),
    scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
    textTheme: Theme.of(context)
        .textTheme
        .copyWith(
          titleMedium:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
        )
        .apply(
          bodyColor: isDarkTheme ? Colors.white : Colors.black,
          displayColor: Colors.grey,
        ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
        isDarkTheme ? Colors.white : Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
    ),
  );
}

class AppColors extends ThemeExtension<AppColors> {
  final Color? color1;
  final Color? color2;
  const AppColors({
    required this.color1,
    required this.color2,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? color1,
    Color? color2,
  }) {
    return AppColors(
      color1: color1,
      color2: color2,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      color1: Color.lerp(color1, other.color1, t),
      color2: Color.lerp(color2, other.color2, t),
    );
  }
}
