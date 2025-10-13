import 'package:up_todo_app/feature/authenticaton/register/data/model/register_model.dart';

abstract class RegisterRepo{
  Future<void>register(RegisterModel model);
  Future<RegisterModel?>getUser();

}