import 'package:up_todo_app/feature/home_screen/person/log_out/domain/repo.dart';

class LogOutUseCase {
  LogOutRepo repo;

  LogOutUseCase(this.repo);

  Future<void> logOut() async {
    await repo.logOut();
  }
}
