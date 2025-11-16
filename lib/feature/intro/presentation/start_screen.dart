import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/reusable_widgets/buttons.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';

import '../../../core/size_config/size_config.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Bounceable(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Color(0xFFFFFFFF)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.widthRatio(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 26,
          children: [
            Text(
              textAlign: TextAlign.center,

              "Welcome to UpTodo",
              style: GoogleFonts.lato(
                color: Color(0xDEFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.widthRatio(32),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              "Please login to your account or create\n new account to continue",
              style: GoogleFonts.lato(
                color: Color(0xABFFFFFF),
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.widthRatio(16),
              ),
              overflow: TextOverflow.visible,
              maxLines: 2,
            ),

            Spacer(),
            Button(
              onPressed: () {
                Navigator.pushNamed(context, PageRouteName.loginScreen);
              },
              text: "LOGIN",
              style: GoogleFonts.lato(
                color: Color(0xFFFFFFFF),
                fontSize: SizeConfig.widthRatio(16),
                fontWeight: FontWeight.w500,
              ),
            ),
            Button(
              onPressed: () {
                Navigator.pushNamed(context, PageRouteName.registerScreen);
              },
              text: "CREATE ACCOUNT",
              style: GoogleFonts.lato(
                color: Color(0xFFFFFFFF),
                fontSize: SizeConfig.widthRatio(16),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
