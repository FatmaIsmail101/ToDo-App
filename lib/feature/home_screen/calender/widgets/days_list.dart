import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';
import 'package:up_todo_app/core/size_config/size_config.dart';

import 'card_date_item.dart';

class DaysList extends StatelessWidget {
  final List<DateTime> days;
  final DateTime? selectedDay;
  final ValueChanged<DateTime>? onDaySelected;

  const DaysList({
    super.key,
    required this.days,
    required this.onDaySelected,
    this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.heightRatio(64),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final date = days[index];
          final dayName = DateFormat("E").format(date).toUpperCase();
          final today = DateTime.now();
          final isToday =
              date.day == today.day &&
              date.month == today.month &&
              date.year == today.year;
          final isSelected =
              selectedDay != null &&
              date.day == selectedDay!.day &&
              date.month == selectedDay!.month &&
              date.year == selectedDay!.year;
          final isWeekend =
              dayName == context.local?.sat || dayName == context.local?.sun;
          return GestureDetector(
            onTap: () {
              if (onDaySelected != null) {
                onDaySelected!(date);
              }
            },
            child: CardDateItem(
              isWeekend: isWeekend,
              isSelected: isSelected || isToday,
              nameOfTheDay: dayName,
              numOfTheDay: date.day,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: SizeConfig.widthRatio(14));
        },
        itemCount: days.length,
      ),
    );
  }
}
