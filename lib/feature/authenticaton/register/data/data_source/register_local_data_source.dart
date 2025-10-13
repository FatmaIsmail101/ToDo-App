import 'package:up_todo_app/feature/authenticaton/register/data/model/register_model.dart';

abstract class RegisterLocalDataSource{
  Future<void>saveUser(RegisterModel model);
  Future<RegisterModel?>getUser();
}