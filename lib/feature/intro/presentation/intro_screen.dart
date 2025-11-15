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
    super.initState();
    CacheHelper.setBool("Intro", true);
  }

  static final List<IntroModel> intos = [
    IntroModel(
      imagePath: Assets.intro1,
      title: "Manage your tasks",
      description: "You can easily manage all of your daily tasks in DoMe for free",
    ),
    IntroModel(
      imagePath: Assets.intro2,
      title: "Create daily routine",
      description: "In Uptodo you can create your personalized routine to stay productive",
    ),
    IntroModel(
      imagePath: Assets.intro3,
      title: "Organize your tasks",
      description: "You can organize your daily tasks by adding your tasks into separate categories",
    ),
  ];

  final PageController _controller = PageController();
  final pageNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    pageNotifier.dispose();
    super.dispose();
  }

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
              child: PageView.builder(
                controller: _controller,
                itemCount: intos.length,
                onPageChanged: (index) {
                  pageNotifier.value = index;
                  print('Page changed to: $index'); // ✅ للتأكد
                },
                itemBuilder: (context, index) {
                  return InteoWidget(
                    model: intos[index],
                    currentIndex: index,
                    totalPage: intos.length,

                  );
                },
              ),
            ),


            // ✅ الأزرار
            ValueListenableBuilder<int>(
              valueListenable: pageNotifier,
              builder: (context, currentPage,
                  _) { // ✅ استخدمي currentPage من هنا!
                bool isLastPage = currentPage == intos.length - 1;

                print(
                    "currentPage: $currentPage, isLastPage: $isLastPage"); // ✅ للتأكد

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: currentPage > 0
                          ? () {
                        print("Back Button pressed");
                        _controller.previousPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                      }
                          : null,
                      child: Text(currentPage == 0 ? "" :
                      "Back",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: currentPage > 0
                              ? Color(0xFFFFFFFF)
                              : Color(0x24FFFFFF),
                        ),
                      ),
                    ),
                    Button(
                      onPressed: () {
                        print("Button pressed, isLastPage: $isLastPage");

                        if (isLastPage) {
                          print("Navigating to start screen");
                          Navigator.pushNamed(
                            context,
                            PageRouteName.startScreen,
                          );
                        } else {
                          print("Going to next page");
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      text: isLastPage ? "GET STARTED" : "NEXT",
                      style: GoogleFonts.lato(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
