import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/size_config/size_config.dart';

class CardNumberOfTasks extends StatelessWidget {
  CardNumberOfTasks({super.key, required this.number, required this.word});
  int number;
  String word;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
          color: Color(0xff979797),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthRatio(22)
              , vertical: SizeConfig.heightRatio(18)),
          child: Text(
            textAlign: TextAlign.center,
            "$number Task $word",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.normal,
              fontSize: SizeConfig.widthRatio(16),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
