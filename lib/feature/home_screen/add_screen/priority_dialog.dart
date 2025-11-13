import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/notification/notification_bar.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/widget/priorty_item.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

import '../person/setteings/fonts/provider/font_provider.dart';

class PriorityDialog extends ConsumerStatefulWidget {
  PriorityDialog({super.key, this.selectedPriorty});

  TaskPriority? selectedPriorty;

  @override
  ConsumerState<PriorityDialog> createState() => _PriorityDialogState();
}

class _PriorityDialogState extends ConsumerState<PriorityDialog> {
  @override
  Widget build(BuildContext context) {
    final selectedFont = ref.watch(fontProvider);

    return Container(
      height: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xff363636),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Text(
              "Task Priority",
              style: GoogleFonts.getFont(selectedFont,
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
                itemBuilder: (context, index) {
                  final priorty = priorityList[index];
                  return PriortyItem(model: priorityList[index],
                    isSelected: widget.selectedPriorty == priorty,
                    selectPriority: () {
                      setState(() {
                        widget.selectedPriorty = priorty;
                      });
                    },);
                },
                itemCount: priorityList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 2, mainAxisSpacing: 16,
                    childAspectRatio: .8
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      NotificationBar.showNotification(
                          message: "Please Select Priorty",
                          type: ContentType.failure
                          ,
                          context: context,
                          icon: Icons.error_outline);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.getFont(selectedFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.selectedPriorty != null) {
                        Navigator.pop(context, widget.selectedPriorty);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        )
                    ),
                    child: Text(
                      "Save",
                      style: GoogleFonts.getFont(selectedFont,
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
