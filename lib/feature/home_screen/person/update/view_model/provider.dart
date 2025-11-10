import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/home_screen/person/update/view_model/providers.dart';

import '../domain/repo/use_case.dart';

final userUseCaseProvider = Provider<UpdateUseCase>((ref) {
  final repo = ref.read(updateRepositoryProvider);
  return UpdateUseCase(repo);
});
final updateViewProvider = StateNotifierProvider<UpdateProvider, LoginModel?>((
  ref,
) {
  final useCase = ref.read(updateUseCaseProvider);
  final loginModel = ref.read(updateProvider);
  return UpdateProvider(useCase, loginModel);
});

class UpdateProvider extends StateNotifier<LoginModel?> {
  UpdateUseCase useCase;

  UpdateProvider(this.useCase, LoginModel? initailModel) : super(initailModel);

  Future<void> updateName(String newName) async {
    if (state == null) return;
    await useCase.updateName(newName);
    state = state!.copyWith(name: newName);
    // try {
    //   if (newName.trim().isNotEmpty) {
    //     await useCase.updateName(newName);
    //     state = AsyncData(null);
    //   }
    // } catch (e, st) {
    //   state = AsyncError(e, st);
    // }
  }

  Future<void> updatePassword(String newPassword) async {
    if (state == null) return;
    await useCase.updatePassword(newPassword);
    state = state!.copyWith(password: newPassword);
    // try {
    //   if (newPassword.trim().isNotEmpty) {
    //     await useCase.updatePassword(newPassword);
    //     state = AsyncData(null);
    //   }
    // } catch (e, st) {
    //   state = AsyncError(e, st);
    // }
  }
}
