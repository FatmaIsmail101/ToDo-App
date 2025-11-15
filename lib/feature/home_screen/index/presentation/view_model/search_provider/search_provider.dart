import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';

final searchProvider = StateProvider<String>((ref) => "");
final filteredTasksProvider = Provider<List<TaskModel>>((ref) {
  final query = ref.watch(searchProvider).toLowerCase();
  final filteredTasks = ref.watch(taskViewModelProvider);
  if (query.isEmpty) {
    return filteredTasks;
  }
  return filteredTasks
      .where(
        (element) => element.title.trim().toLowerCase().contains(
          query.trim().toLowerCase(),
        ),
      )
      .toList();
});

final notComplete = Provider<List<TaskModel>>((ref) {
  final notCompleteTasks = ref.watch(filteredTasksProvider);
  return notCompleteTasks.where((element) => !element.isComplete).toList();
});
final completeTasks = Provider<List<TaskModel>>((ref) {
  final completeTasks = ref.watch(filteredTasksProvider);
  return completeTasks.where((element) => element.isComplete).toList();
});
