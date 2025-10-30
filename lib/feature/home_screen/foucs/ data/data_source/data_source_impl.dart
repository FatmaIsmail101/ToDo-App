import 'dart:convert';

import 'package:up_todo_app/core/casheing/cache_helper.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/data_source/data_source.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/model/time_model.dart';

class TimerDSImpl implements TimerDataSource {
  @override
  Future<void> clearTimer() async {
    await CacheHelper.remove("timer");
  }

  @override
  TimerModel? getTimer() {
    final jsonString = CacheHelper.getString("timer");
    if (jsonString == null) {
      return null;
    }
    return TimerModel.fromJson(jsonDecode(jsonString));
  }

  @override
  Future<void> saveTimer(TimerModel model) async {
    await CacheHelper.setString("timer", jsonEncode(model.toJson()));
  }
}
