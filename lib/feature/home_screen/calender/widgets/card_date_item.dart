import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../person/setteings/fonts/provider/font_provider.dart';

class CardDateItem extends ConsumerWidget {
  CardDateItem({
    required this.isWeekend,
    super.key,
    this.isSelected = true,
    required this.nameOfTheDay,
    required this.numOfTheDay,
  });

  String nameOfTheDay;
  int numOfTheDay;
  bool isWeekend;
  bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato"
        : selectedFont;

    return Container(
      width: 44,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? Color(0xff8685E7) : Color(0x0fffffff),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Text(
              nameOfTheDay.toUpperCase(),
              style: GoogleFonts.getFont(
                safeFont,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isWeekend ? Colors.red : Color(0xe0ffffff),
              ),
            ),
            Text(
              "$numOfTheDay",
              style: GoogleFonts.getFont(
                safeFont,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xe0ffffff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
