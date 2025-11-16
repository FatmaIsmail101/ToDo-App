import 'package:flutter/material.dart';
import 'package:up_todo_app/core/size_config/size_config.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    super.key,
    required this.totalDot,
    required this.currentIndex,
  });

  final int totalDot;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 9,
      children: List.generate(totalDot, (index) {
        bool isActive = index == currentIndex;
        return AnimatedContainer(
          duration: Duration(seconds: 1),
          width: isActive
              ? SizeConfig.widthRatio(28)
              : SizeConfig.widthRatio(8),
          height: 4,
          decoration: BoxDecoration(
            color: isActive ? Color(0xdeffffff) : Colors.grey,
          ),
        );
      }),
    );
  }
}
