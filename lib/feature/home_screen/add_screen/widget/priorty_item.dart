import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

class PriortyItem extends StatelessWidget {
  PriortyItem({super.key, required this.model});

  TaskPriority model;
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? Colors.blue.shade100 : Colors.black,
      ),
      child: Column(
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
    );
  }
}
