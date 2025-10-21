import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/widget/task_item.dart';

import '../../../../core/routes/page_route_name.dart';

class AllTasks extends ConsumerWidget {
  const AllTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskViewModelProvider);
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(top: 20),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              PageRouteName.editScreen,
              arguments: taskState[index],
            );
          },
          child: TaskItem(model: taskState[index]),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemCount: taskState.length,
      ),
    );
  }
}
