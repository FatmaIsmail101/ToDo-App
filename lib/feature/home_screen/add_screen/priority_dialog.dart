import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/widget/priorty_item.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

class PriorityDialog extends StatelessWidget {
  PriorityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Text(
              "Task Priority",
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(color: Colors.white),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) =>
                    PriortyItem(model: priorityList[index]),
                itemCount: priorityList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Save",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<TaskPriority> priorityList = [
    TaskPriority(level: 1, label: Icons.flag),
    TaskPriority(level: 2, label: Icons.flag),
    TaskPriority(level: 3, label: Icons.flag),
    TaskPriority(level: 4, label: Icons.flag),
    TaskPriority(level: 5, label: Icons.flag),
    TaskPriority(level: 6, label: Icons.flag),
    TaskPriority(level: 7, label: Icons.flag),
    TaskPriority(level: 8, label: Icons.flag),
    TaskPriority(level: 9, label: Icons.flag),
    TaskPriority(level: 10, label: Icons.flag),
  ];
}
