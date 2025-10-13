import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';

abstract class LoginRepo{
  Future<LoginModel>login(String name,String password);
  Future<LoginModel?>getSavedUser();

}