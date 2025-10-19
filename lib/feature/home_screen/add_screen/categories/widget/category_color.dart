import 'package:flutter/material.dart';

class CategoryColor extends StatelessWidget {
  CategoryColor({
    super.key,
    required this.color,
    required this.isSelectedColor,
  });

  Color color;
  bool isSelectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: isSelectedColor == true ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }
}

/*
CircleAvatar(
      backgroundColor: color,
      radius: 20,
    )
 */
