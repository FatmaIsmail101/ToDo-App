import 'package:up_todo_app/feature/authenticaton/login/data/data_source/data_source.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';

import '../../../../../core/casheing/cache_helper.dart';

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<LoginModel?> getUser() async {
    final name = CacheHelper.getString("name");
    final password = CacheHelper.getString("password");
    if (name != null && password != null) {
      return LoginModel(name: name, password: password);
    }

    return null;
  }

  @override
  Future<void> saveUser(LoginModel model) async {
    await CacheHelper.setString("name", model.name);
    await CacheHelper.setString("password", model.password);
    }
}
