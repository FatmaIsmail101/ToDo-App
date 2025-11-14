import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

import '../../person/setteings/fonts/provider/font_provider.dart';

class CategoryItem extends ConsumerWidget {
  CategoryItem(
      {super.key, required this.model, required this.selected, this.isSelected = true});

  Category model;
  final VoidCallback selected;
  bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty || selectedFont == null)
        ? "Lato"
        : selectedFont;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        InkWell(
          onTap: selected,
          child: Container(
            alignment: Alignment.center,
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: model.color,
                border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent)
            ),
            child: Icon(model.icon),
          ),
        ),
        Text(
          model.name,
          style: GoogleFonts.getFont(safeFont,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
