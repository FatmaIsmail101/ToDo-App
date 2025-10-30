import 'package:up_todo_app/feature/home_screen/foucs/%20data/model/time_model.dart';

abstract class TimerDataSource {
  Future<void> saveTimer(TimerModel model);

  TimerModel? getTimer();

  Future<void> clearTimer();
}
