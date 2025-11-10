import 'dart:convert';

import 'package:up_todo_app/feature/authenticaton/register/data/data_source/register_local_data_source.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/model/register_model.dart';

import '../../../../../core/casheing/cache_helper.dart';

class RegisterLocalDataSourceImpl implements RegisterLocalDataSource {
  @override
  Future<RegisterModel?> getUser() async {
    final savedUser = CacheHelper.getString("user");
    final savedPin = CacheHelper.getString("pin");
    final savedIsFingerPrint = CacheHelper.getBool("finger");
    if (savedUser != null && savedUser.isNotEmpty) {
      final data = jsonDecode(savedUser);
      final model = RegisterModel.fromJson(data);
      model.pin = savedPin;
      model.isFingerprintEnabled = savedIsFingerPrint;
      return model;
    }
    return null;
  }

  @override
  Future<void> saveUser(RegisterModel model) async {
    await CacheHelper.setString("user", jsonEncode(model.toJson()));
    if (model.pin != null) {
      await CacheHelper.setString("pin", model.pin!);
    }
    if (model.isFingerprintEnabled != null) {
      await CacheHelper.setBool("finger", model.isFingerprintEnabled!);
    }
  }
}
