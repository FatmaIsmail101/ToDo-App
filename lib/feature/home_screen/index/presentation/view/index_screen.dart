import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/assets/assets.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/widget/task_item.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view_model/search_provider/search_provider.dart';

import '../../../person/image/provider.dart';
import '../../../person/setteings/fonts/provider/font_provider.dart';

class IndexScreen extends ConsumerWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskViewModelProvider);
    final notCompleted = ref.watch(notComplete);
    final completed = ref.watch(completeTasks);
    final imagePath = ref.watch(pickImage);
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // ✅ مهم
            children: [
              _buildHeader(context, imagePath ?? "", ref),
              const SizedBox(height: 20),

              taskState.isEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.min, // ✅ مهم
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image(image: AssetImage(Assets.indexPIC)),
                        const SizedBox(height: 16),
                        Text(
                          context.local?.what_do_you_want_today ?? "",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.local?.tap_to_add_tasks ?? "",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextField(
                        onChanged: (value) {
                          ref.read(searchProvider.notifier).state = value;
                        },
                        decoration: InputDecoration(
                          hintText: context.local?.search_for_task ?? "",
                          hintStyle: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.black,
                        ),
                        style: GoogleFonts.getFont(
                          safeFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),

              const SizedBox(height: 20),

              // محتوى المهام
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    if (notCompleted.isNotEmpty) ...[
                      _sectionTitle(context.local?.not_completed ?? "", ref),
                      ..._taskList(notCompleted, context),
                    ],
                    if (completed.isNotEmpty) ...[
                      _sectionTitle(context.local?.completed ?? "", ref),
                      ..._taskList(completed, context),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String image, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.more_horiz, color: Colors.white),
        Text(
          context.local?.index ?? "",
          style: GoogleFonts.getFont(
            safeFont,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        CircleAvatar(
          backgroundImage: (image.isNotEmpty) ? FileImage(File(image)) : null,
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: GoogleFonts.getFont(
          safeFont,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _taskList(List<TaskModel> tasks, BuildContext context) {
    return tasks
        .map(
          (task) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                PageRouteName.editScreen,
                arguments: task,
              ),
              child: TaskItem(model: task),
            ),
          ),
        )
        .toList();
  }
}

/*
class IndexScreen extends ConsumerWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskViewModelProvider);
    final notCompleted = ref.watch(notComplete);
    final completed = ref.watch(completeTasks);
    final imagePath = ref.watch(pickImage);
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            _buildHeader(context, imagePath ?? "", ref),
            taskState.isEmpty
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(Assets.indexPIC)),
                    Text(
                      context.local?.what_do_you_want_today ?? "",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      context.local?.tap_to_add_tasks ?? "",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
                : Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextField(
                      onChanged: (value) {
                        ref.read(searchProvider.notifier).state = value;
                      },
                      //controller: _searchController,
                      decoration: InputDecoration(
                        hintText: context.local?.search_for_task ?? "",
                        hintStyle: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        focusColor: Colors.white,
                      ),
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
            //Content
            SizedBox(
              height: MediaQuery.of(context).size.height*.6,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  if (notCompleted.isNotEmpty) ...[
                    _sectionTitle(context.local?.not_completed ?? "", ref),
                    _taskList(notCompleted, context),
                  ],
                  if (completed.isNotEmpty) ...[
                    _sectionTitle(context.local?.completed ?? "", ref),
                    _taskList(completed, context),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String image, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.more_horiz, color: Colors.white),
        Text(
          context.local?.index ?? "",
          style: GoogleFonts.getFont(
            safeFont,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        CircleAvatar(backgroundImage: AssetImage(image ?? "")),
      ],
    );
  }

  _sectionTitle(String title, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato" : selectedFont;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 12),
      child: Text(
        title,
        style: GoogleFonts.getFont(
          safeFont,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _taskList(List<TaskModel> tasks, BuildContext context) {
    return Column(
      children: [
        for (final task in tasks)
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                PageRouteName.editScreen,
                arguments: task,
              ),
              child: TaskItem(model: task),
            ),
          ),
      ],
    );
  }
}

 */
//class _IndexSecreenState extends ConsumerState<IndexScreen> {
//final _searchController = TextEditingController();

//}

/*
 if (notCompleted.isNotEmpty) ...[
                Text(
                  context.local?.not_completed ?? "",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        print(
                          "Navigation to edit screen with: ${taskState[index].title}",
                        );
                        Navigator.pushNamed(
                          context,
                          PageRouteName.editScreen,
                          arguments: notCompleted[index],
                        );
                      },
                      child: TaskItem(model: notCompleted[index]),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemCount: notCompleted.length,
                  ),
                ),
              ],
              if (Completed.isNotEmpty) ...[
                Text(
                  context.local?.completed ?? "",

                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        // print(
                        //   "Navigation to edit screen with: ${taskState[index].title}",
                        // );
                        Navigator.pushNamed(
                          context,
                          PageRouteName.editScreen,
                          arguments: Completed[index],
                        );
                      },
                      child: TaskItem(model: Completed[index]),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemCount: Completed.length,
                  ),
                ),
              ],
 */
/*
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskViewModelProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.more_horiz, color: Colors.white),
                Text(
                  "Index",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(backgroundImage: AssetImage(Assets.profilePIC)),
              ],
            ),
            taskState.isEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage(Assets.indexPIC)),
                        Text(
                          "What do you want to do today?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Tap + to add your tasks",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                :
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for your task...",
                      hintStyle: GoogleFonts.lato(
                        fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey
                      ),
                      prefixIcon: Icon(Icons.search,color: Colors.white,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.black,
                      focusColor: Colors.white,

                    ),
                    style: GoogleFonts.lato(
                        fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey
                    ),
                  ),
                ),
            Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 20),
                      itemBuilder: (context, index) =>
                          InkWell(

                              onTap: () {
                                print(
                                    "Navigation to edit screen with: ${taskState[index]
                                        .title}");
                                Navigator.pushNamed(
                                    context, PageRouteName.editScreen,
                                    arguments: taskState[index]);
                              },
                              child: TaskItem(model: taskState[index])),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      itemCount: taskState.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

 */
