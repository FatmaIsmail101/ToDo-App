import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/home_screen/person/name/domain/repo/repo.dart';

class UpdateUseCase {
  UpdateRepo repo;

  UpdateUseCase(this.repo);

  Future<LoginModel?> updateName(String newName) async {
    return await repo.updateName(newName);
  }

  Future<LoginModel?> updatePassword(String newPassword) async {
    return await repo.updatePassword(newPassword);
  }
}
