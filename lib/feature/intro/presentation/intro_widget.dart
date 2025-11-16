import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/intro/data/model/intero_model.dart';
import 'package:up_todo_app/feature/intro/presentation/dots_indicator.dart';

import '../../../core/size_config/size_config.dart';

class InteoWidget extends StatelessWidget {
  const InteoWidget({
    super.key,
    required this.model,
    required this.currentIndex,
    required this.totalPage,
  });

  final IntroModel model;
  final int currentIndex;
  final int totalPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 3,
          child: RepaintBoundary(
            child: Image.asset(
              model.imagePath,
              cacheWidth: SizeConfig.widthRatio(800).toInt(),
              cacheHeight: SizeConfig.heightRatio(800).toInt(),
            ),
          ),
        ),
        //ValueListenableBuilder(valueListenable: p, builder: builder)
        DotsIndicator(totalDot: totalPage, currentIndex: currentIndex),
        Text(
          model.title,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.widthRatio(28),
            color: Color(0xFFFFFFFF),
          ),
        ),
        Text(
          model.description,
          style: GoogleFonts.lato(
            fontSize: SizeConfig.widthRatio(12),
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          softWrap: true,
        ),
      ],
    );
  }
}
