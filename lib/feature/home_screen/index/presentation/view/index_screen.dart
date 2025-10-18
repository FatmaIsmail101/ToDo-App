import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/widget/task_item.dart';

import '../../../../../core/assets/assets.dart';

class IndexScreen extends ConsumerStatefulWidget {
  const IndexScreen({super.key});

  @override
  ConsumerState<IndexScreen> createState() => _IndexSecreenState();
}

class _IndexSecreenState extends ConsumerState<IndexScreen> {
  final _searchController = TextEditingController();
  List<TaskModel> filterd = [];

  void _searchFunction() {
    String querry = _searchController.text.toLowerCase();
    final tasksList = ref.read(taskViewModelProvider);
    setState(() {
      filterd = tasksList.where((element) {
        return element.title.toLowerCase().contains(querry);
      }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final tasksList = ref.read(taskViewModelProvider);
      setState(() {
        filterd = tasksList;
      });
      _searchController.addListener(_searchFunction);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskViewModelProvider);
    final notCompleted = taskState
        .where((element) => element.isComplete == false)
        .toList();
    final Completed = taskState
        .where((element) => element.isComplete == true)
        .toList();

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
                : Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search for your task...",
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
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
            if (notCompleted.isNotEmpty) ...[
              Text(
                "Not Completed",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
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
                "Not Completed",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
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
          ],
        ),
      ),
    );
  }
}

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
