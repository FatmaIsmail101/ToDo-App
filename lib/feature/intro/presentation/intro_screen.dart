import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/casheing/cache_helper.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';
import 'package:up_todo_app/feature/intro/data/model/intero_model.dart';

import '../../../core/assets/assets.dart';
import '../../../core/reusable_widgets/buttons.dart';
import 'intro_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CacheHelper.setBool("Intro", true);
  }

  List<IntroModel> intos = [
    IntroModel(
      imagePath: Assets.intro1,
      title: "Manage your tasks",
      description:
          "You can easily manage all of your daily tasks in DoMe for free",
    ),
    IntroModel(
      imagePath: Assets.intro2,
      title: "Create daily routine",
      description:
          "In Uptodo  you can create your personalized routine to stay productive",
    ),
    IntroModel(
      imagePath: Assets.intro3,
      title: "Organize your tasks",
      description:
          "You can organize your daily tasks by adding your tasks into separate categories",
    ),
  ];

  final PageController _controller = PageController();

  bool get endPage => currentPage == intos.length - 1;

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, PageRouteName.startScreen);
          },
          child: Text(
            "Skip",
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  //todo:
                  setState(() {
                    currentPage = index;
                  });
                },
                children: intos
                    .map(
                      (model) => InteoWidget(
                        model: model,
                        currentIndex: currentPage,
                        totalPage: intos.length,
                      ),
                    )
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if ((_controller.page ?? 0) > 0) {
                      _controller.previousPage(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    }
                    int nextPage = ((_controller.page ?? 0).toInt() + 1);
                  },
                  child: Text(
                    "Back",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0x24FFFFFF),
                    ),
                  ),
                ),
                Button(
                  onPressed: () {
                    int nextPage = (_controller.page!.toInt() + 1);
                    if (nextPage < 3) {
                      _controller.animateToPage(
                        nextPage,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                    if (nextPage == 3) {
                      Navigator.pushNamed(context, PageRouteName.startScreen);
                    }
                  },
                  text: endPage ? "GET STARED" : "NEXT",
                  style: GoogleFonts.lato(
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
