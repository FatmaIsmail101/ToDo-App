import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/home_screen/person/update/view_model/provider.dart';

// 🧩 Data Layer
// 🧠 Domain Layer

import '../../../../authenticaton/login/presentation/providers/auth_providers.dart';
import '../data/data_source/data_source.dart';
import '../data/data_source/data_source_impl.dart';
import '../data/repo/repo_impl.dart';
import '../domain/repo/repo.dart';
import '../domain/repo/use_case.dart';

// ✅ 1. DataSource Provider
final authLocalDataSourceProvider = Provider<DataSourceName>((ref) {
  return DataSourceImpl(); // هنا هتستخدمي CacheHelper جوه
});

// ✅ 2. Repository Provider
final updateRepositoryProvider = Provider<UpdateRepo>((ref) {
  final dataSource = ref.read(authLocalDataSourceProvider);
  return UpdateRepoImpl(dataSource);
});

// ✅ 3. UseCase Provider
final updateUseCaseProvider = Provider<UpdateUseCase>((ref) {
  final repository = ref.read(updateRepositoryProvider);
  return UpdateUseCase(repository);
});

// ✅ 4. ViewModel Provider
final updateProvider =
StateNotifierProvider<UpdateProvider, LoginModel?>((ref) {
  final loginState = ref.read(loginViewModelProvider);
  final loginModel = loginState.model;
      final updateUseCase = ref.read(updateUseCaseProvider);
  return UpdateProvider(updateUseCase, loginModel);
    });
