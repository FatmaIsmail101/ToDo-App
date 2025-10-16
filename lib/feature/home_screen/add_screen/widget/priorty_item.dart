import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

class PriortyItem extends StatelessWidget {
  PriortyItem(
      {super.key, required this.model, required this.isSelected, required this.selectPriority});

  TaskPriority model;
  bool isSelected = true;
  final VoidCallback selectPriority;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: selectPriority,
      child: Container(
        alignment: Alignment.center,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xff272727),
            border: Border.all(
                color: isSelected ? Colors.greenAccent : Colors.transparent
            )
        ),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(model.label, color: Colors.white),
            Text(
              "${model.level}",
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
