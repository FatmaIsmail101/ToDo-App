import 'package:up_todo_app/feature/home_screen/person/log_out/data/data_source/data_source.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/domain/repo.dart';

class LogOutRepoImpl implements LogOutRepo {
  LogOutDataSource dataSource;

  LogOutRepoImpl(this.dataSource);

  @override
  Future<void> logOut() async {
    await dataSource.logOut();
  }
}
