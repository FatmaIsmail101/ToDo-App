import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_todo_app/core/size_config/size_config.dart';
import 'package:up_todo_app/feature/home_screen/person/presentation/view/person_screen.dart';
import 'package:up_todo_app/feature/home_screen/person/setteings/theme/provider.dart';

import 'add_screen/add_screen.dart';
import 'calender/calender_screen.dart';
import 'foucs/presentation/view/foucs_screen.dart';
import 'index/presentation/view/index_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  final List<Widget> screens = [
    const RepaintBoundary(child: IndexScreen()),
    const RepaintBoundary(child: CalenderScreen()),
    const SizedBox.shrink(), // AddScreen handled separately
    const RepaintBoundary(child: FoucsScreen()),
    RepaintBoundary(child: PersonScreen()),
  ];

  @override
  void dispose() {
    currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);
    final darkThemePreview = FlexThemeData.dark(scheme: selectedColor);
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final currentColor = isDark ? darkThemePreview : themePreview;

    return Scaffold(
      backgroundColor: currentColor.colorScheme.primary,
      body: ValueListenableBuilder<int>(
        valueListenable: currentIndexNotifier,
        builder: (context, currentIndex, _) {
          return IndexedStack(
            index: currentIndex,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentIndexNotifier,
        builder: (context, currentIndex, _) {
          return ConvexAppBar(
            style: TabStyle.custom,

            elevation: 4,
            activeColor: Colors.blue,
            items: const [
              TabItem(icon: Icons.home_filled),
              TabItem(icon: Icons.calendar_month),
              TabItem(icon: Icons.add),
              TabItem(icon: Icons.access_time),
              TabItem(icon: Icons.person,),
            ],
            backgroundColor: currentColor.colorScheme.primary,
            color: Colors.white,
            height: SizeConfig.heightRatio(60),
            initialActiveIndex: currentIndex,
            onTap: (index) {
              if (index == 2) {
                showModalBottomSheet(
                  context: context,

                  isScrollControlled: true,
                  builder: (_) => AddScreen(),
                );
              } else {
                currentIndexNotifier.value = index;
              }
            },
          );
        },
      ),
    );
  }
}

/*
Scaffold(
     // resizeToAvoidBottomInset: false,
      backgroundColor: currentColor.colorScheme.primary,
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
        backgroundColor: currentColor.colorScheme.primary,
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
              backgroundColor: currentColor.colorScheme.primary,
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
 */