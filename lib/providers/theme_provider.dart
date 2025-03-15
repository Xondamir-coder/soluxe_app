import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/helpers/preference_helper.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    final theme = await PreferenceHelper.getTheme();
    state = theme;
  }

  void setTheme(bool val) async {
    state = val;
    await PreferenceHelper.saveTheme(state);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(),
);
