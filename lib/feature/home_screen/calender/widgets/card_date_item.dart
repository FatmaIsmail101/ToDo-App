import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/size_config/size_config.dart';
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
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;

    return Container(
      padding: EdgeInsets.all(SizeConfig.widthRatio(4)),
      width: SizeConfig.widthRatio(44),
      height: SizeConfig.heightRatio(44),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
        color: isSelected ? Color(0xff8685E7) : Color(0x0fffffff),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            nameOfTheDay.toUpperCase(),
            style: GoogleFonts.getFont(
              safeFont,
              fontSize: SizeConfig.widthRatio(12),
              fontWeight: FontWeight.bold,
              color: isWeekend ? Colors.red : Color(0xe0ffffff),
            ),
          ),
          Text(
            "$numOfTheDay",
            style: GoogleFonts.getFont(
              safeFont,
              fontSize: SizeConfig.widthRatio(12),
              fontWeight: FontWeight.bold,
              color: Color(0xe0ffffff),
            ),
          ),
        ],
      ),
    );
  }
}
