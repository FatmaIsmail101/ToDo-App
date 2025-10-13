import 'package:up_todo_app/core/casheing/cache_helper.dart';
import 'package:up_todo_app/core/error_handling/error_handling.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/data_source/data_source.dart';
import 'package:up_todo_app/feature/authenticaton/login/data/model/login_model.dart';
import 'package:up_todo_app/feature/authenticaton/login/domain/login_repo/login_repo.dart';

class LoginRepoImpl implements LoginRepo{
 LocalDataSource local;
 LoginRepoImpl(this.local);
  @override
  Future<LoginModel?> getSavedUser() {
    return local.getUser();
  }

  @override
  Future<LoginModel> login(String name, String password) async {
    final saved = await local.getUser();

    if (saved == null) {
      throw ToDoErrorHandle("Please Enter a Value");
    }

    print("🟢 Saved: ${saved.name}, ${saved.password}");
    print("🟡 Input: $name, $password");

    // ✅ استخدمي trim() هنا
    if (saved.name.trim() != name.trim() || saved.password.trim() != password.trim()) {
      throw ToDoErrorHandle("Invalid value");
    }

    return saved;
  }

}
