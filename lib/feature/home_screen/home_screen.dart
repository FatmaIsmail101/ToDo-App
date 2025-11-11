import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/add_screen.dart';
import 'package:up_todo_app/feature/home_screen/calender/calender_screen.dart';
import 'package:up_todo_app/feature/home_screen/foucs/presentation/view/foucs_screen.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/index_screen.dart';
import 'package:up_todo_app/feature/home_screen/person/presentation/view/person_screen.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/theme/provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themePreview.colorScheme.primary,
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
        backgroundColor: themePreview.colorScheme.primary,
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
              backgroundColor: themePreview.colorScheme.primary,
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
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
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
