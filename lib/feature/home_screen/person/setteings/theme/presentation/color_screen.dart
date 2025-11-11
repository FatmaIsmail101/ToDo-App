import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/theme/provider.dart';

class ColorScreen extends ConsumerWidget {
  int index = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(themeSchemeProvider);
    final notifier = ref.read(themeSchemeProvider.notifier);
    //final scheme=FlexScheme.values[index];
    final themePreview = FlexThemeData.light(scheme: selectedColor);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themePreview.colorScheme.primary,
        title: Text(
          "Color Screen",
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
      body: ListView.builder(
        itemCount: FlexScheme.values.length,
        itemBuilder: (context, index) {
          final scheme = FlexScheme.values[index];
          final themePreview = FlexThemeData.light(scheme: scheme);

          return GestureDetector(
            onTap: () {
              //حطينا scheme  عشان خاطر اللى اخترناها من index
              notifier.setTheme(scheme);
            },
            child: Container(
              width: 20,
              height: 40,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themePreview.colorScheme.primary,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: scheme == selectedColor
                      ? Colors.black
                      : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
