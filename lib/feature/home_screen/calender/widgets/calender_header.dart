import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:up_todo_app/feature/home_screen/calender/view_model/calender_view_model.dart';

import '../../../../core/size_config/size_config.dart';
import '../../person/setteings/fonts/provider/font_provider.dart';

class CalenderHeader extends ConsumerWidget {
  final VoidCallback goToPrev;
  final VoidCallback goToNext;

  const CalenderHeader({
    super.key,
    required this.goToPrev,
    required this.goToNext,
    required this.currentDate,
  });

  final DateTime currentDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;

    final state = ref.watch(calenderProvider);
    final notifier = ref.read(calenderProvider.notifier);
    final nameMonth = DateFormat(
      "MMMM",
    ).format(state.currentDate).toUpperCase();
    final year = DateFormat("yyyy").format(state.currentDate);

    return Container(
      width: double.infinity,
      color: Color(0xff202020),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthRatio(16),
          vertical: SizeConfig.heightRatio(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: goToPrev,
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nameMonth.toUpperCase(),
                style: GoogleFonts.getFont(
                  safeFont,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.widthRatio(14),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: SizeConfig.heightRatio(20),
                child: Text(
                  year,
                  style: GoogleFonts.getFont(
                    safeFont,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.widthRatio(10),
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: goToNext,
            icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
