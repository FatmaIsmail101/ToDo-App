import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/home_screen/person/update/data/data_source/data_source.dart';

import '../../domain/repo/repo.dart';

class UpdateRepoImpl implements UpdateRepo {
  DataSourceName dataSourceName;

  UpdateRepoImpl(this.dataSourceName);

  @override
  @override
  Future<LoginModel?> updateName(String newName) async {
    await dataSourceName.updateName(newName);
    return null;
  }

  @override
  Future<LoginModel?> updatePassword(String newPassword) async {
    await dataSourceName.updatePassword(newPassword);
    return null;
  }
}
