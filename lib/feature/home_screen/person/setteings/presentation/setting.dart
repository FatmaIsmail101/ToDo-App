import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';

import '../theme/provider.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);

    return Scaffold(
      backgroundColor: themePreview.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: themePreview.colorScheme.primary,
        title: Text(
          "Settings",
          style: GoogleFonts.lato(
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
              "Settings",
              style: GoogleFonts.lato(
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
                    "Change app color",
                    style: GoogleFonts.lato(
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
            Row(
              spacing: 10,
              children: <Widget>[
                Icon(Icons.text_fields, color: Colors.white, size: 35),
                Text(
                  "Change app typography",
                  style: GoogleFonts.lato(
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
            Row(
              spacing: 10,
              children: <Widget>[
                Icon(Icons.language, color: Colors.white, size: 35),
                Text(
                  "Change app language",
                  style: GoogleFonts.lato(
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
            Text(
              "Import",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Row(
              spacing: 10,
              children: <Widget>[
                Icon(Icons.import_export, color: Colors.white, size: 25),
                Text(
                  "Import from Google calendar",
                  style: GoogleFonts.lato(
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
