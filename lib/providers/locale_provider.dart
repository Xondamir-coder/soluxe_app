import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/helpers/preference_helper.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    _loadLocale();
  }

  void _loadLocale() async {
    final code = await PreferenceHelper.getLanguage();
    state = Locale(code);
  }

  void setLocale(String code) async {
    state = Locale(code);
    await PreferenceHelper.saveLanguage(code);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);
