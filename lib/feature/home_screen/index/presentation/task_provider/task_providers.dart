import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/index/data/data_source/task_data_source.dart';
import 'package:up_todo_app/feature/home_screen/index/data/data_source/task_data_source_impl.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/data/repo/task_repo_impl.dart';
import 'package:up_todo_app/feature/home_screen/index/domain/repo/tasks_repo.dart';
import 'package:up_todo_app/feature/home_screen/index/domain/use_case/task_use_case.dart';

import '../view_model/task_view_model.dart';

// ✅ 1. DataSource Provider
final taskLocalDataSourceProvider = Provider<TaskDataSource>((ref) {
  return TaskDataSourceImpl(); // هنا هتستخدمي CacheHelper جوه
});

// ✅ 2. Repository Provider
final taskRepositoryProvider = Provider<TaskRepo>((ref) {
  final dataSource = ref.read(taskLocalDataSourceProvider);
  return TaskRepoImpl(dataSource);
});

// ✅ 3. UseCase Provider
final taskUseCaseProvider = Provider<TaskUseCase>((ref) {
  final repository = ref.read(taskRepositoryProvider);
  return TaskUseCase(repository);
});

// ✅ 4. ViewModel Provider
final taskViewModelProvider =
    StateNotifierProvider<TaskViewModel, List<TaskModel>>((ref) {
      final taskUseCase = ref.read(taskUseCaseProvider);
      return TaskViewModel(taskUseCase);
    });

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, List<Category>>((ref) {
      final taskUseCase = ref.read(taskUseCaseProvider);
      return CategoryViewModel(taskUseCase);
    });