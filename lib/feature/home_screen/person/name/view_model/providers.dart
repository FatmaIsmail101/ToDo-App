import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/person/name/data/data_source.dart';
import 'package:up_todo_app/feature/home_screen/person/name/data/repo_impl.dart';
import 'package:up_todo_app/feature/home_screen/person/name/domain/repo/repo.dart';
import 'package:up_todo_app/feature/home_screen/person/name/domain/repo/use_case.dart';
import 'package:up_todo_app/feature/home_screen/person/name/view_model/provider.dart';

// 🧩 Data Layer
// 🧠 Domain Layer

import '../data/data_source_impl.dart';

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
final loginViewModelProvider =
    StateNotifierProvider<UpdateProvider, AsyncValue>((ref) {
      final updateUseCase = ref.read(updateUseCaseProvider);
      return UpdateProvider(updateUseCase);
    });
