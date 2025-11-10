import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/domain/use_case.dart';

// final logOutProvider =
// StateNotifierProvider<LogOutProvider,LoginViewModel?>(
//       (ref) => LogOutProvider(ref.read(logOutUseCaseProvider)),
// );

class LogOutProvider extends StateNotifier<LoginModel?> {
  LogOutUseCase useCase;

  LogOutProvider(this.useCase) : super(null);

  Future<void> removeAccount() async {
    await useCase.logOut();
    state = null;
  }
}
