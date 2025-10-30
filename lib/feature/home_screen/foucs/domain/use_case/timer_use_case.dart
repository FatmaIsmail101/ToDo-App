import 'package:up_todo_app/feature/home_screen/foucs/domain/repo/timer_repo.dart';

import '../../ data/model/time_model.dart';

class TimerUseCase {
  TimerRepo repo;

  TimerUseCase(this.repo);

  Future<void> saveTimer(TimerModel model) async {
    await repo.saveTimer(model);
  }

  TimerModel? getTimer() {
    return repo.getTimer();
  }

  Future<void> clearTimer() async {
    await repo.clearTimer();
  }
}
