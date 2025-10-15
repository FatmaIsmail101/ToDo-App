import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, required this.model});

  Category model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Container(
            alignment: Alignment.center,
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: model.color,
            ),
            child: Icon(model.icon),
          ),
          Text(
            model.name,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
