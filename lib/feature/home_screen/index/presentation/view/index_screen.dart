import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/widget/task_item.dart';

import '../../../../../core/assets/assets.dart';

class IndexScreen extends ConsumerWidget {
  const IndexScreen({super.key});

  @override
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
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          TaskItem(model: taskState[index]),
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
}
