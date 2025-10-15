import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/data_source/data_source.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/data_source/data_source_impl.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/repo/login_repo_impl.dart';
import 'package:up_todo_app/feature/authenticaton/login/domain/login_repo/login_repo.dart';
import 'package:up_todo_app/feature/authenticaton/login/presentation/view_model/login_state.dart';

// 🧩 Data Layer
import '../../domain/login_use_case/login_use_case.dart';
// 🧠 Domain Layer

import '../view_model/view_model.dart';

// ✅ 1. DataSource Provider
final authLocalDataSourceProvider = Provider<LocalDataSource>((ref) {
  return LocalDataSourceImpl(); // هنا هتستخدمي CacheHelper جوه
});

// ✅ 2. Repository Provider
final authRepositoryProvider = Provider<LoginRepo>((ref) {
  final dataSource = ref.read(authLocalDataSourceProvider);
  return LoginRepoImpl(dataSource);
});

// ✅ 3. UseCase Provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
});

// ✅ 4. ViewModel Provider
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
      final loginUseCase = ref.read(loginUseCaseProvider);
      return LoginViewModel(loginUseCase);
    });
