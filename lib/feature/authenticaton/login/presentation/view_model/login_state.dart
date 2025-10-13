import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';

class LoginState {
  final LoginStatus state;
  final LoginModel? model;
  final String? error;

  LoginState({this.model, required this.state, this.error});
}

enum LoginStatus { idle, loading, success, needLocalAuth, error }
