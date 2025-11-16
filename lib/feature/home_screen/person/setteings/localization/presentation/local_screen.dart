import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/localization/provider/provider.dart';

import '../../../../../../core/size_config/size_config.dart';
import '../../fonts/provider/font_provider.dart';
import '../../theme/provider.dart';

class LocalizationScreen extends ConsumerWidget {
  const LocalizationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);
    final darkThemePreview = FlexThemeData.dark(scheme: selectedColor);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentColor = isDark ? darkThemePreview : themePreview;
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;
    final local = ref.watch(localization);
    return Scaffold(
      backgroundColor: currentColor.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: currentColor.colorScheme.primary,
        title: Text(
          context.local?.localeName ?? "",
          style: GoogleFonts.getFont(
            safeFont,
            fontWeight: FontWeight.normal,
            fontSize: SizeConfig.widthRatio(20),
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
        padding: EdgeInsets.all(SizeConfig.widthRatio(24)),
        child: Column(
          spacing: SizeConfig.heightRatio(20),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(localization.notifier).changeLanguage("ar");
                  },
                  child: Text(
                    "Arabic",
                    style: GoogleFonts.getFont(
                      safeFont,
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConfig.widthRatio(20),
                      color: Colors.white,
                    ),
                  ),
                ),
                local == "ar"
                    ? Icon(Icons.check, color: Colors.green,
                    size: SizeConfig.widthRatio(30))
                    : SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(localization.notifier).changeLanguage("en");
                  },
                  child: Text(
                    "English",
                    style: GoogleFonts.getFont(
                      safeFont,
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConfig.widthRatio(20),
                      color: Colors.white,
                    ),
                  ),
                ),
                local == "en"
                    ? Icon(Icons.check, color: Colors.green,
                    size: SizeConfig.widthRatio(30))
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
