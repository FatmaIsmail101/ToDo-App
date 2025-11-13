import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/fonts/provider/font_provider.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/theme/provider.dart';

final appThemeProvider = Provider<ThemeData>((ref) {
  final scheme = ref.watch(themeSchemeProvider);
  final font = ref.watch(fontProvider);
  return FlexThemeData.light(scheme: scheme, useMaterial3: true,
      fontFamily: GoogleFonts
          .getFont(font)
          .fontFamily);
});

final appDarkThemeProvider = Provider<ThemeData>((ref) {
  final scheme = ref.watch(themeSchemeProvider);
  final font = ref.watch(fontProvider);

  return FlexThemeData.dark(scheme: scheme, useMaterial3: true, fontFamily:
  GoogleFonts
      .getFont(font)
      .fontFamily);
});
