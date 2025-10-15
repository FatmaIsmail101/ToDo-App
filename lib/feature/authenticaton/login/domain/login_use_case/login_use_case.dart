import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/authenticaton/login/domain/login_repo/login_repo.dart';


class LoginUseCase{
  LoginRepo repo;
  LoginUseCase(this.repo);
  Future<LoginModel>excute(String name,String password){
    return repo.login(name, password);
  }
}