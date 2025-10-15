import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/add_screen.dart';
import 'package:up_todo_app/feature/home_screen/calender/calender_screen.dart';
import 'package:up_todo_app/feature/home_screen/foucs/foucs_screen.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/index_screen.dart';
import 'package:up_todo_app/feature/home_screen/person/person_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: ConvexAppBar(
        elevation: 20,
        activeColor: Colors.blue,
        items: [
          TabItem(icon: Icons.home_filled),
          TabItem(icon: Icons.calendar_month),
          TabItem(icon: Icons.add),
          TabItem(icon: Icons.access_time),
          TabItem(icon: Icons.person),
        ],
        backgroundColor: Colors.black,
        //style: TabStyle.react,
        color: Colors.white,
        height: 100,
        curve: Curves.easeInOut,
        initialActiveIndex: currentIndex,
        onTap: (index) {
          if (index == 2) {
            // يعني الزر +
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (_) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 24,
                ),
                child: AddScreen(),
              ),
            );
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
      body: screens[currentIndex],
    );
  }

  List<Widget> screens = [
    IndexScreen(),
    CalenderScreen(),
    Container(), // مكان add فاضي
    FoucsScreen(),
    PersonScreen(),
  ];
}
