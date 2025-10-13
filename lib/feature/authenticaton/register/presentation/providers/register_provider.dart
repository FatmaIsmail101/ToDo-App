import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/data_source/data_source.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/data_source/data_source_impl.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/repo/login_repo_impl.dart';
import 'package:up_todo_app/feature/authenticaton/login/domain/login_repo/login_repo.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/data_source/register_local_data_source.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/data_source/register_local_data_source_impl.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/model/register_model.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/repo/register_repo_impl.dart';
import 'package:up_todo_app/feature/authenticaton/register/domain/repo/register_repo.dart';
import 'package:up_todo_app/feature/authenticaton/register/domain/use_case/register_use_case.dart';

import '../view_model/register_view_model.dart';

// 🧩 Data Layer

// 🧠 Domain Layer


// ✅ 1. DataSource Provider
final RegisterLocalDataSourceProvider = Provider<RegisterLocalDataSource>((ref) {
  return RegisterLocalDataSourceImpl(); // هنا هتستخدمي CacheHelper جوه
});

// ✅ 2. Repository Provider
final RegisterRepositoryProvider = Provider<RegisterRepo>((ref) {
  final dataSource = ref.read(RegisterLocalDataSourceProvider);
  return RegisterRepoImpl(dataSource);
});

// ✅ 3. UseCase Provider
final RegisterUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.read(RegisterRepositoryProvider);
  return RegisterUseCase(repository);
});

// ✅ 4. ViewModel Provider
final registerViewModelProvider =
StateNotifierProvider<RegisterViewModel, AsyncValue<void>>((ref) {
  final registerUseCase = ref.read(RegisterUseCaseProvider);
  return RegisterViewModel(registerUseCase);
});
