import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/core/casheing/cache_helper.dart';

final fontProvider = StateNotifierProvider<FontNotifier, String>((ref) {
  return FontNotifier();
});

class FontNotifier extends StateNotifier<String> {
  FontNotifier() : super("Lato") {
    _loadFont();
  }

  Future<void> _loadFont() async {
    final savedFont = CacheHelper.getString("font") ?? "Lato";
    state = savedFont;
  }

  Future<void> setFont(String fontName) async {
    CacheHelper.setString("font", fontName);
    state = fontName;
  }
}
