import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/theme/provider.dart';

import '../../../../../../core/size_config/size_config.dart';

class ColorScreen extends ConsumerWidget {
  const ColorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(themeSchemeProvider);
    final notifier = ref.read(themeSchemeProvider.notifier);

    final themePreview = FlexThemeData.light(scheme: selectedColor);
    final darkThemePreview = FlexThemeData.dark(scheme: selectedColor);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentColor = isDark ? darkThemePreview : themePreview;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentColor.colorScheme.primary,
        title: Text(
          context.local?.color_screen ?? "",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.normal,
            fontSize: SizeConfig.widthRatio(20),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: SizeConfig.heightRatio(60),
        iconTheme: IconThemeData(color: Colors.white),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, size: SizeConfig.widthRatio(18),),
        ),
      ),
      body: ListView.builder(
        itemCount: FlexScheme.values.length,
        itemBuilder: (context, index) {
          final scheme = FlexScheme.values[index];
          final themePreview = FlexThemeData.light(scheme: scheme);
          final darkThemeePreview = FlexThemeData.dark(scheme: scheme);
          final isLight = Theme.of(context).brightness == Brightness.light;
          final colors = isLight ? themePreview : darkThemeePreview;
          return GestureDetector(
            onTap: () {
              //حطينا scheme  عشان خاطر اللى اخترناها من index
              notifier.setTheme(scheme);
            },
            child: Container(
              width: SizeConfig.widthRatio(20),
              height: SizeConfig.heightRatio(40),
              margin: EdgeInsets.all(SizeConfig.widthRatio(8)),
              decoration: BoxDecoration(
                color: colors.colorScheme.primary,
                borderRadius: BorderRadius.circular(SizeConfig.widthRatio(6)),
                border: Border.all(
                  color: scheme == selectedColor
                      ? Colors.black
                      : Colors.transparent,
                  width: SizeConfig.widthRatio(3),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
