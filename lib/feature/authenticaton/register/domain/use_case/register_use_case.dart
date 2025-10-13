import 'package:up_todo_app/feature/authenticaton/register/data/model/register_model.dart';
import 'package:up_todo_app/feature/authenticaton/register/domain/repo/register_repo.dart';

class RegisterUseCase{
  RegisterRepo repo;
  RegisterUseCase(this.repo);
  Future<void>call(RegisterModel model)async {
    await repo.register(model);
  }
}