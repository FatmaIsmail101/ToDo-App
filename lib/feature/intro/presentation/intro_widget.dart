import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/intro/data/model/intero_model.dart';
import 'package:up_todo_app/feature/intro/presentation/dots_indicator.dart';

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
    return  Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Flexible(
          flex: 3,
          child: RepaintBoundary(
            child: Image.asset(
              model.imagePath,
              cacheHeight: 800,
              cacheWidth: 800,
            ),
          ),
        ),
        //ValueListenableBuilder(valueListenable: p, builder: builder)
        DotsIndicator(totalDot: totalPage, currentIndex: currentIndex),
        Text(
          model.title,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            width: 320,
            child: Text(
              model.description,
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFFFFFF),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      )
    ;
  }
}
