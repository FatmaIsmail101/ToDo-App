import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel model;

  TaskItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color(0xff363636),
        ),
        child: Row(
          spacing: 12,
          children: [
            Icon(
              model.isComplete ? Icons.circle_rounded : Icons.circle_outlined,
              color: model.isComplete ? Color(0xff8875FF) : Colors.transparent,
            ),
            Expanded(
              child: Column(
                spacing: 6,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    formateTaskDate(model.dateTime),
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 88,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: model.category.color,
              ),
              child: Row(
                children: [
                  Icon(model.category.icon),
                  Text(
                    model.category.name,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 88,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xffE8E8E8),
              ),
              child: Row(
                children: [
                  Icon(model.priority.label),
                  Text(
                    "${model.priority.level}",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
