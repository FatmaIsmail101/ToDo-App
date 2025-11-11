import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/theme/provider.dart';

final appThemeProvider = Provider<ThemeData>((ref) {
  final scheme = ref.watch(themeSchemeProvider);
  return FlexThemeData.light(scheme: scheme, useMaterial3: true);
});

final appDarkThemeProvider = Provider<ThemeData>((ref) {
  final scheme = ref.watch(themeSchemeProvider);
  return FlexThemeData.dark(scheme: scheme, useMaterial3: true);
});
