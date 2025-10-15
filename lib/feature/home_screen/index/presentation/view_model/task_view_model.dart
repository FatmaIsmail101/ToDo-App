import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/index/domain/use_case/task_use_case.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';

import '../../data/model/task_model.dart';

final taskViewModelProvider =
    StateNotifierProvider<TaskViewModel, List<TaskModel>>(
      (ref) => TaskViewModel(ref.read(taskUseCaseProvider)),
    );

class TaskViewModel extends StateNotifier<List<TaskModel>> {
  TaskUseCase useCase;

  TaskViewModel(this.useCase) : super([]) {
    loadTask();
  }

  Future<void> loadTask() async {
    final tasks = await useCase.getAllTasksUseCas();
    state = tasks;
  }

  Future<void> addTask(TaskModel task) async {
    await useCase.addTaskUseCase(task);
    state = [...state, task];
  }

  Future<void> editTask(TaskModel task) async {
    await useCase.editTaskUseCase(task);
    final index = state.indexWhere((element) => element.id == task.id);
    if (index != -1) {
      final updated = [...state];
      updated[index] = task;
      state = updated;
    }
  }

  Future<void> removeTask(String id) async {
    await useCase.removeTaskUseCas(id);
    state = state.where((element) => element.id != id).toList();
  }
}
