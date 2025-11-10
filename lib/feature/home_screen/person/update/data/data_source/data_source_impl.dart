import 'dart:convert';

import 'package:up_todo_app/core/casheing/cache_helper.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/home_screen/person/update/data/data_source/data_source.dart';

class DataSourceImpl implements DataSourceName {
  @override
  Future<void> updateName(String newName) async {
    try {
      String? data = CacheHelper.getString("user");
      if (data == null || data.isEmpty) {
        return;
      }
      final decod = jsonDecode(data);
      LoginModel model = LoginModel.fromJson(decod);
      model.name = newName;
      await CacheHelper.setString("user", jsonEncode(model.toJson()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    final data = CacheHelper.getString("user");
    if (data == null || data.isEmpty) {
      return;
    }
    final decode = jsonDecode(data);
    LoginModel model = LoginModel.fromJson(decode);
    model.password = newPassword;
    await CacheHelper.setString("user", jsonEncode(model.toJson()));
  }
}
