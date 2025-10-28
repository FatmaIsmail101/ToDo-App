import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

final editViewModelProvider =
    StateNotifierProvider.family<EditTaskNotifier, TaskModel, TaskModel>(
      (ref, model) => EditTaskNotifier(model),
    );

class EditTaskNotifier extends StateNotifier<TaskModel> {
  EditTaskNotifier(TaskModel model) : super(model);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void updateTitleAndDesc(String title, String description) {
    state = state.copyWith(title: title, description: description);
  }

  void newCategory(Category category) {
    state = state.copyWith(category: category);
  }

  void newPriority(TaskPriority priority) {
    state = state.copyWith(priority: priority);
  }

  void newDate(DateTime dateTime) {
    state = state.copyWith(dateTime: dateTime);
  }

  void toggleComplete() {
    state = state.copyWith(isComplete: !state.isComplete);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
