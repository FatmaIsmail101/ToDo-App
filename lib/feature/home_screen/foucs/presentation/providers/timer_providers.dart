// ✅ 1. DataSource Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/data_source/data_source.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/data_source/data_source_impl.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/model/time_model.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/repo/repo_impl.dart';
import 'package:up_todo_app/feature/home_screen/foucs/domain/repo/timer_repo.dart';
import 'package:up_todo_app/feature/home_screen/foucs/domain/use_case/timer_use_case.dart';
import 'package:up_todo_app/feature/home_screen/foucs/presentation/provider/timer_provider.dart';

final timerLocalDataSourceProvider = Provider<TimerDataSource>((ref) {
  return TimerDSImpl(); // هنا هتستخدمي CacheHelper جوه
});

// ✅ 2. Repository Provider
final timerRepositoryProvider = Provider<TimerRepo>((ref) {
  final dataSource = ref.read(timerLocalDataSourceProvider);
  return TimerRepoImpl(dataSource);
});

// ✅ 3. UseCase Provider
final timerUseCaseProvider = Provider<TimerUseCase>((ref) {
  final repository = ref.read(timerRepositoryProvider);
  return TimerUseCase(repository);
});

// ✅ 4. ViewModel Provider
final timerViewModelProvider =
    StateNotifierProvider<TimerNotifier, TimerModel?>((ref) {
      final loginUseCase = ref.read(timerUseCaseProvider);
      return TimerNotifier(loginUseCase);
    });
