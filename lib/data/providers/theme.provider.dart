import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/consts/const.dart';
import '../../core/helpers/helper.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final saved = HSharedPreferences.instance.getString(CStorageKey.themeMode);
    return ThemeMode.values.firstWhere((mode) => mode.name == saved, orElse: () => ThemeMode.system);
  }

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    HSharedPreferences.instance.setString(CStorageKey.themeMode, state.name);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
