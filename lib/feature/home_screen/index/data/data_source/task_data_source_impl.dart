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
  Future<List<TaskModel>> getAllTasks() async {
    final jsonString = CacheHelper.getString("tasks");
    if (jsonString == null) return [];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => TaskModel.fromJson(e)).toList();
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
}
