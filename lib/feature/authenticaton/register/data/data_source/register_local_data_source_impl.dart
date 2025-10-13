import 'package:up_todo_app/feature/authenticaton/register/data/data_source/register_local_data_source.dart';
import 'package:up_todo_app/feature/authenticaton/register/data/model/register_model.dart';

import '../../../../../core/casheing/cache_helper.dart';

class RegisterLocalDataSourceImpl implements RegisterLocalDataSource {
  @override
  Future<RegisterModel?> getUser() async {
    final savedNameUser = CacheHelper.getString("name");
    final savedPasswordUser = CacheHelper.getString("password");
    final savedPin=CacheHelper.getString("pin");
    final savedIsFingerPrint=CacheHelper.getBool("finger");
    if (savedNameUser != null &&
        savedPasswordUser != null ) {
      return RegisterModel(
        name: savedNameUser ,
        password: savedPasswordUser ,
        confirmPassword: savedPasswordUser ,
        pin: savedPin,isFingerprintEnabled: savedIsFingerPrint
      );
    }
    return null;
  }

  @override
  Future<void> saveUser(RegisterModel model) async {
    await CacheHelper.setString("name", model.name.trim());
    await CacheHelper.setString("password", model.password.trim());
    if (model.pin != null) {
      await CacheHelper.setString("pin", model.pin!);
    }
    if (model.isFingerprintEnabled != null) {
      await CacheHelper.setBool("finger", model.isFingerprintEnabled!);
    }
  }
}
