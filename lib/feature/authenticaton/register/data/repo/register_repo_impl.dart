import 'package:up_todo_app/core/error_handling/error_handling.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/data_source/register_local_data_source.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/model/register_model.dart';
import 'package:up_todo_app/feature/authenticaton/register/domain/repo/register_repo.dart';

class RegisterRepoImpl implements RegisterRepo {
  RegisterLocalDataSource local;

  RegisterRepoImpl(this.local);

  @override
  Future<void> register(RegisterModel model) async {
    final existingUser = await local.getUser();
    if (existingUser != null && existingUser.name == model.name) {
      throw ToDoErrorHandle("This Account is already existing");
    }
    if (model.password != model.confirmPassword) {
      throw ToDoErrorHandle("The Password doesn't match");
    }

    await local.saveUser(
      RegisterModel(
        name: model.name,
        password: model.password,
        confirmPassword: model.confirmPassword,
      ),
    );
  }

  @override
  Future<RegisterModel?> getUser() {
    return local.getUser();
  }
}
