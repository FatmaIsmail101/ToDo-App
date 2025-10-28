import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/calender/widgets/task_tabs.dart';

import '../../../../core/routes/page_route_name.dart';
import '../../index/presentation/task_provider/task_providers.dart';
import '../../index/presentation/view/widget/task_item.dart';

class ListTask extends ConsumerWidget {
  const ListTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskViewModelProvider);
    final complete = taskState.where((element) {
      return element.isComplete == true;
    }).toList();
    final notComplete = taskState
        .where((element) => element.isComplete == false)
        .toList();
    final selectedTab = ref.watch(selectedTabProvider);
    final filteredTasks = selectedTab == 0 ? notComplete : complete;
    if (filteredTasks.isEmpty) {
      return Center(
        child: Text(
          "No tasks available",
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(right: 24, left: 24),
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                PageRouteName.editScreen,
                arguments: task,
              );
            },
            child: TaskItem(model: task),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },
        itemCount: filteredTasks.length,
      ),
    );
  }
}
