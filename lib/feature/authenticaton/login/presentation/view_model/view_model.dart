import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/core/error_handling/error_handling.dart';
import 'package:up_todo_app/feature/authenticaton/login/domain/login_use_case/login_use_case.dart';
import 'package:up_todo_app/feature/authenticaton/login/presentation/view_model/login_state.dart';

import '../providers/auth_providers.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>(
      (ref) => LoginViewModel(ref.read(loginUseCaseProvider)),
    );

class LoginViewModel extends StateNotifier<LoginState> {
  final LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase)
    : super(LoginState(state: LoginStatus.idle));

  Future<void> login(String name, String password) async {
    if (name.isEmpty ||
        password.isEmpty ||
        name.trim().isEmpty ||
        password.trim().isEmpty) {
      state = LoginState(
        state: LoginStatus.error,
        error: "Please Enter email and Password",
      );
      return;
    }
    state = LoginState(state: LoginStatus.loading);
    try {
      final user = await loginUseCase.excute(name.trim(), password.trim());
      state = LoginState(state: LoginStatus.success, model: user);
    } catch (e) {
      final message = e is ToDoErrorHandle ? e.message : "Something went Wrong";
      state = LoginState(state: LoginStatus.error, error: e.toString());
    }
  }
}
