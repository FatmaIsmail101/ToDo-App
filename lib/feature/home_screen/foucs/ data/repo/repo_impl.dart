import 'package:up_todo_app/feature/home_screen/foucs/%20data/data_source/data_source.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/model/time_model.dart';
import 'package:up_todo_app/feature/home_screen/foucs/domain/repo/timer_repo.dart';

class TimerRepoImpl implements TimerRepo {
  TimerDataSource ds;

  TimerRepoImpl(this.ds);

  @override
  Future<void> clearTimer() async {
    await ds.clearTimer();
  }

  @override
  TimerModel? getTimer() {
    return ds.getTimer();
  }

  @override
  Future<void> saveTimer(TimerModel model) async {
    await ds.saveTimer(model);
  }
}
