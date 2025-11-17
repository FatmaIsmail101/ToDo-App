import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/fonts/provider/font_provider.dart';

import '../../../../../../core/size_config/size_config.dart';
import '../../theme/provider.dart';

class FontScreen extends ConsumerWidget {
  const FontScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato"
        : selectedFont;
    final notifer = ref.read(fontProvider.notifier);
    final fontList = [
      'Lato',
      'Roboto',
      'Montserrat',
      'Poppins',
      'Open Sans',
      'Cairo',
      'Nunito',
      'Playfair Display',
      'Raleway',
      'Merriweather',
    ];
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);
    final darkThemePreview = FlexThemeData.dark(scheme: selectedColor);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentColor = isDark ? darkThemePreview : themePreview;

    return Scaffold(
      backgroundColor: currentColor.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: currentColor.colorScheme.primary,
        centerTitle: true,
        title: Text(
          context.local?.fonts ?? "",
          style: GoogleFonts.getFont(
            safeFont,
            fontSize: SizeConfig.widthRatio(22),
            color: Colors.white,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, size: SizeConfig.widthRatio(15),),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final fontName = fontList[index];
          return ListTile(
            title: Text(
              fontName,
              style: GoogleFonts.getFont(
                fontName,
                fontSize: SizeConfig.widthRatio(22),
                color: Colors.white,
              ),
            ),
            onTap: () {
              notifer.setFont(fontName);
            },
            trailing: safeFont == fontName
                ? Icon(Icons.check, color: Colors.green)
                : null,
          );
        },
        itemCount: fontList.length,
      ),
    );
  }
}
