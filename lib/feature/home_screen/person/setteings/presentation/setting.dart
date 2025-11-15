import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';

import '../fonts/provider/font_provider.dart';
import '../theme/provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);
    final darkThemePreview = FlexThemeData.dark(scheme: selectedColor);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentColor = isDark ? darkThemePreview : themePreview;
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato"
        : selectedFont;

    return Scaffold(
      backgroundColor: currentColor.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: currentColor.colorScheme.primary,
        title: Text(
          context.local?.settings ?? "",
          style: GoogleFonts.getFont(
            safeFont,
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              context.local?.settings ?? "",
              style: GoogleFonts.getFont(
                safeFont,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageRouteName.colorScreen);
              },
              child: Row(
                spacing: 10,
                children: <Widget>[
                  Icon(Icons.format_paint_sharp, color: Colors.white, size: 35),
                  Text(
                    context.local?.change_app_color ?? "",
                    style: GoogleFonts.getFont(
                      safeFont,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageRouteName.fontScreen);
              },
              child: Row(
                spacing: 10,
                children: <Widget>[
                  Icon(Icons.text_fields, color: Colors.white, size: 35),
                  Text(
                    context.local?.change_app_typography ?? "",
                    style: GoogleFonts.getFont(
                      safeFont,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageRouteName.localizationScreen);
              },
              child: Row(
                spacing: 10,
                children: <Widget>[
                  Icon(Icons.language, color: Colors.white, size: 35),
                  Text(
                    context.local?.change_app_language ?? "",
                    style: GoogleFonts.getFont(
                      safeFont,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
            ),
            Text(
              context.local?.import ?? "",
              style: GoogleFonts.getFont(
                safeFont,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Row(
              spacing: 4,
              children: <Widget>[
                Icon(Icons.import_export, color: Colors.white, size: 25),
                Text(
                  context.local?.import_from_google_calendar ?? "",
                  style: GoogleFonts.getFont(
                    safeFont,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),

                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
