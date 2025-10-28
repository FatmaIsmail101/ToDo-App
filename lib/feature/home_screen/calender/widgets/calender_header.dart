import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:up_todo_app/feature/home_screen/calender/view_model/calender_view_model.dart';

class CalenderHeader extends ConsumerWidget {
  final VoidCallback goToPrev;
  final VoidCallback goToNext;

  const CalenderHeader({
    Key? key,
    required this.goToPrev,
    required this.goToNext,
    required this.currentDate,
  }) : super(key: key);
  final DateTime currentDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calenderProvider);
    final notifier = ref.read(calenderProvider.notifier);
    final nameMonth = DateFormat(
      "MMMM",
    ).format(state.currentDate).toUpperCase();
    final year = DateFormat("yyyy").format(state.currentDate);

    return Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xff202020),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: goToPrev,
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Column(
              children: [
                Text(
                  nameMonth.toUpperCase(),
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    year,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: goToNext,
              icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
