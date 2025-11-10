import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';

abstract class UpdateRepo {
  Future<LoginModel?> updateName(String newName);

  Future<LoginModel?> updatePassword(String newPassword);
}
