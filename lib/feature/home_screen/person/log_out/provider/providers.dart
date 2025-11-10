import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/data/data_source/data_source.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/data/data_source/data_source_impl.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/data/repo/repo_impl.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/domain/repo.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/domain/use_case.dart';

import '../view_model/provider.dart';

// ✅ 1. DataSource Provider
final logOutDataSourceProvider = Provider<LogOutDataSource>((ref) {
  return LogOutDSImpl(); // هنا هتستخدمي CacheHelper جوه
});

// ✅ 2. Repository Provider
final logOutRepositoryProvider = Provider<LogOutRepo>((ref) {
  final dataSource = ref.read(logOutDataSourceProvider);
  return LogOutRepoImpl(dataSource);
});

// ✅ 3. UseCase Provider
final logOutUseCaseProvider = Provider<LogOutUseCase>((ref) {
  final repository = ref.read(logOutRepositoryProvider);
  return LogOutUseCase(repository);
});

// ✅ 4. ViewModel Provider
final logOutProvider = StateNotifierProvider<LogOutProvider, LoginModel?>((
  ref,
) {
  final useCase = ref.read(logOutUseCaseProvider);
  return LogOutProvider(useCase);
});
