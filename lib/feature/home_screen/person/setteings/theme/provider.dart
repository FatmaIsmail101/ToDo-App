import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/core/casheing/cache_helper.dart';

final themeSchemeProvider =
    StateNotifierProvider<ThemeSchemeNotifier, FlexScheme>((ref) {
      return ThemeSchemeNotifier();
    });

class ThemeSchemeNotifier extends StateNotifier<FlexScheme> {
  ThemeSchemeNotifier() : super(FlexScheme.mandyRed) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = CacheHelper.getInt("theme") ?? 5;
    state = FlexScheme.values[savedTheme];
  }

  Future<void> setTheme(FlexScheme scheme) async {
    final index = FlexScheme.values.indexOf(scheme);
    CacheHelper.setInt("theme", index);
    state = scheme;
  }
}
