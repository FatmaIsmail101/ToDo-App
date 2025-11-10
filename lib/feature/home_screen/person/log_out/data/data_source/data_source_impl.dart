import 'package:up_todo_app/core/casheing/cache_helper.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/data/data_source/data_source.dart';

class LogOutDSImpl implements LogOutDataSource {
  @override
  Future<void> logOut() async {
    await CacheHelper.remove("user");
  }
}
