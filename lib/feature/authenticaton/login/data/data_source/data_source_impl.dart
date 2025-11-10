import 'dart:convert';

import 'package:up_todo_app/feature/authenticaton/login/data/data_source/data_source.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';

import '../../../../../core/casheing/cache_helper.dart';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<LoginModel?> getUser() async {
    final data = CacheHelper.getString("user");
    if (data != null && data.isNotEmpty) {
      final decoded = jsonDecode(data);
      return LoginModel.fromJson(decoded);
    }

    return null;
  }

  @override
  Future<void> saveUser(LoginModel model) async {
    final encoudedUser = jsonEncode(model.toJson());
    await CacheHelper.setString("user", encoudedUser);
  }
}
