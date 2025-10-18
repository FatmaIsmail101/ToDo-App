import 'package:flutter/material.dart';
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

final categoryViewModelProvider =
StateNotifierProvider<CategoryViewModel, List<Category>>(
      (ref) => CategoryViewModel(ref.read(taskUseCaseProvider)),
);

class CategoryViewModel extends StateNotifier<List<Category>> {
  final TaskUseCase useCase;

  CategoryViewModel(this.useCase) : super([]) {
    loadCatgories();
  }

  Future<void> loadCatgories() async {
    final categories = await useCase.getAllCategories();
    final List<Category>merged = [
      ...categoryesList.take(categoryesList.length - 1),
      ...categories,
      categoryesList.last
    ];
    state = merged;
  }

  Future<void> addCategory(Category model) async {
    await useCase.addCategory(model);
    final updated = [...state];
    updated.insert(updated.length - 1, model);
    state = updated;
  }

  List<Category> categoryesList = [
    Category(
      name: "Grocery",
      color: Colors.lightGreenAccent,
      icon: Icons.local_grocery_store,
    ),
    //0
    Category(name: "Work", color: Colors.red, icon: Icons.work),
    //1
    Category(
      name: "Sport",
      color: Colors.greenAccent,
      icon: Icons.sports_baseball,
    ),
    //2
    Category(
      name: "Design",
      color: Colors.greenAccent,
      icon: Icons.design_services,
    ),
    //3
    Category(
      name: "University",
      color: Colors.blue.shade200,
      icon: Icons.cast_for_education,
    ),
    //4
    Category(
      name: "Social",
      color: Colors.pink.shade200,
      icon: Icons.social_distance,
    ),
    //5
    Category(
      name: "Music",
      color: Colors.pink.shade200,
      icon: Icons.music_note,
    ),
    //6
    Category(
      name: "Health",
      color: Colors.greenAccent.shade700,
      icon: Icons.health_and_safety,
    ),
    //7
    Category(name: "Movie", color: Colors.blue.shade100, icon: Icons.movie),
    //8
    Category(name: "Home", color: Color(0xffFFCC80), icon: Icons.home),
    //9
    Category(name: "Create New", color: Color(0xff80FFD1), icon: Icons.add),
    //10
  ];

}
