import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardNumberOfTasks extends StatelessWidget {
  CardNumberOfTasks({Key? key, required this.number, required this.word})
    : super(key: key);
  int number;
  String word;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color(0xff979797),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18),
          child: Text(
            "$number Task $word",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
