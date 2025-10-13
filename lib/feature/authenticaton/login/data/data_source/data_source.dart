import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';

abstract class LocalDataSource{
  Future<void>saveUser(LoginModel model);
  Future<LoginModel?>getUser();
}