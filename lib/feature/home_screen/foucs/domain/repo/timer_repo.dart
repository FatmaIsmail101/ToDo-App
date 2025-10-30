import '../../ data/model/time_model.dart';

abstract class TimerRepo {
  Future<void> saveTimer(TimerModel model);

  TimerModel? getTimer();

  Future<void> clearTimer();
}
