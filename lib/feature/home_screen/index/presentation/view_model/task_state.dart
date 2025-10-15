import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

class TaskState {
  final List<TaskModel> tasks;
  final bool isLoading;

  TaskState({required this.tasks, required this.isLoading});
}
