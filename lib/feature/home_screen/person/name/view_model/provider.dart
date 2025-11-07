import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/person/name/domain/repo/use_case.dart';
import 'package:up_todo_app/feature/home_screen/person/name/view_model/providers.dart';

final userUseCaseProvider = Provider<UpdateUseCase>((ref) {
  final repo = ref.read(updateRepositoryProvider);
  return UpdateUseCase(repo);
});
final updateProvider = StateNotifierProvider<UpdateProvider, AsyncValue<void>>((
  ref,
) {
  final useCase = ref.read(updateUseCaseProvider);
  return UpdateProvider(useCase);
});

class UpdateProvider extends StateNotifier<AsyncValue<void>> {
  UpdateUseCase useCase;

  UpdateProvider(this.useCase) : super(AsyncValue.data(null));

  Future<void> updateName(String newName) async {
    state = AsyncLoading();
    try {
      if (newName.trim().isNotEmpty) {
        await useCase.updateName(newName);
        state = AsyncData(newName);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updatePassword(String newPassword) async {
    state = AsyncLoading();
    try {
      if (newPassword.trim().isNotEmpty) {
        await useCase.updatePassword(newPassword);
        state = AsyncData(newPassword);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
