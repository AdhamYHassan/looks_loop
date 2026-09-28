import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/helpers/shared_prefs_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_getInitialTheme());

  static ThemeMode _getInitialTheme() {
    final themeStr = SharedPrefsHelper.getThemeMode();
    if (themeStr == 'dark') return ThemeMode.dark;
    return ThemeMode.light; // Defaults to Light Mode
  }

  void toggleTheme() {
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    SharedPrefsHelper.setThemeMode(
      newTheme == ThemeMode.dark ? 'dark' : 'light',
    );
    emit(newTheme);
  }

  void setThemeMode(ThemeMode mode) {
    SharedPrefsHelper.setThemeMode(
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
    emit(mode);
  }
}
