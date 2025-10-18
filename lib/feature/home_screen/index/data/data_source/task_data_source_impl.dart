import 'dart:convert';

import 'package:up_todo_app/core/casheing/cache_helper.dart';
import 'package:up_todo_app/feature/home_screen/index/data/data_source/task_data_source.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

class TaskDataSourceImpl implements TaskDataSource {
  @override
  Future<void> addTask(TaskModel task) async {
    final tasks = await getAllTasks();
    tasks.add(task);
    final jsonList = tasks.map((model) => model.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await CacheHelper.setString("tasks", jsonString);
  }

  @override
  Future<void> editTask(TaskModel task) async {
    final tasks = await getAllTasks();
    final index = tasks.indexWhere((element) => element.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
    final jsonList = tasks.map((model) => model.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await CacheHelper.setString("tasks", jsonString);
  }

  @override
  @override
  Future<List<TaskModel>> getAllTasks() async {
    final jsonString = CacheHelper.getString("tasks");

    // ✅ لو مفيش داتا أو نص فاضي
    if (jsonString == null || jsonString.isEmpty) return [];

    try {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      // ✅ لو حصل خطأ في الـ JSON نفسه (مثلاً corrupted data)
      print("Error decoding tasks JSON: $e");
      return [];
    }
  }

  @override
  Future<void> removeTask(String id) async {
    final tasks = await getAllTasks();
    final index = tasks.indexWhere((element) => element.id == id);
    if (index != -1) {
      tasks.removeAt(index);
    }
    final jsonList = tasks.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    CacheHelper.setString("tasks", jsonString);
  }

  @override
  Future<void> addCategory(Category model) async {
    final categoryList = await getAllCategory();
    categoryList.add(model);
    final jsonList = categoryList.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await CacheHelper.setString("categoryList", jsonString);
  }

  @override
  Future<List<Category>> getAllCategory() async {
    final categoryList = await CacheHelper.getString("categoryList");
    if (categoryList!.isEmpty || categoryList == null) return [];
    try {
      final List decoded = jsonDecode(categoryList);
      return decoded.map((e) => Category.fromJson(e),).toList();
    } catch (e) {
      print("Error decoding category JSON: $e");
      return [];
    }
  }
}
