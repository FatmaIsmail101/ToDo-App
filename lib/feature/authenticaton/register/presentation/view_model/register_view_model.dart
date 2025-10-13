import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/model/register_model.dart';
import 'package:up_todo_app/feature/authenticaton/register/domain/use_case/register_use_case.dart';

class RegisterViewModel extends StateNotifier<AsyncValue<void>> {
  final RegisterUseCase useCase;

  RegisterViewModel(this.useCase) : super(const AsyncData(null));

  Future<void> register(
    String name,
    String password,
    String confirmPassword,
  ) async {
    state = const AsyncLoading();
    try {
      final model = RegisterModel(
        name: name,
        password: password,
        confirmPassword: confirmPassword,
      );
      await useCase(model);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
