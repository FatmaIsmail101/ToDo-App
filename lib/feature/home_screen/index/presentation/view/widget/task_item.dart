import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

import '../../../../../../core/size_config/size_config.dart';
import '../../../../person/setteings/fonts/provider/font_provider.dart';

class TaskItem extends ConsumerWidget {
  TaskModel model;

  TaskItem({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SizeConfig.widthRatio(10)),
      height: SizeConfig.heightRatio(130),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
        color: Color(0xff363636),
      ),
      child: Row(
        spacing: SizeConfig.widthRatio(12),
        children: [
          Icon(
            size: SizeConfig.widthRatio(20),
            model.isComplete ? Icons.circle_rounded : Icons.circle_outlined,
            color: model.isComplete ? Color(0xff8875FF) : Colors.white,
          ),
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,

              spacing: SizeConfig.heightRatio(6),
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: GoogleFonts.getFont(selectedFont,
                    fontSize: SizeConfig.widthRatio(16),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                // Spacer(),
                Text(
                  DateFormat('hh:mm a, dd/MM/yyyy').format(model.dateTime),
                  style: GoogleFonts.getFont(selectedFont,
                    fontSize: SizeConfig.widthRatio(14),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthRatio(7)),
            // width: 88,
            // height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
              color: model.category.color,
            ),
            child: Row(
              children: [
                Icon(model.category.icon, size: SizeConfig.widthRatio(18)),
                Text(
                  model.category.name,
                  style: GoogleFonts.getFont(selectedFont,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.widthRatio(12),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthRatio(7)),

            // width: 88,
            // height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
                color: Colors.transparent,
                border: Border.all(color: Colors.lightBlue)),
            child: Row(
              children: [
                Icon(model.priority.label, color: Colors.white,
                  size: SizeConfig.widthRatio(18),),
                Text(
                  "${model.priority.level}",
                  style: GoogleFonts.getFont(selectedFont,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.widthRatio(12),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formateTaskDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final difference = taskDate.difference(today).inDays;
    String dayText;
    if (difference == 0) {
      dayText = "Today";
    } else if (difference == 1) {
      dayText = "Tomorrow";
    } else {
      dayText = "${taskDate.day}/${taskDate.month}/${taskDate.year}";
    }
    final timeText =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return "$dayText At $timeText";
  }
}
