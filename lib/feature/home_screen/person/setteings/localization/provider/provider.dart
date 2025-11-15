import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/core/casheing/cache_helper.dart';

final localization = StateNotifierProvider<LocalizationNotifier, String>((ref) {
  return LocalizationNotifier();
});

class LocalizationNotifier extends StateNotifier<String> {
  LocalizationNotifier() : super("en") {
    _loadLanguage();
  }

  void changeLanguage(String langCode) {
    state = langCode;
    CacheHelper.setString("local", langCode);
  }

  void _loadLanguage() {
    final saved = CacheHelper.getString("local") ?? "en";
    if (saved != "ar" && saved != "en") {
      state = "en";
    } else {
      state = saved;
    }
  }
}
