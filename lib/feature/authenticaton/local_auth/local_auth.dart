import 'package:local_auth/local_auth.dart';
import 'package:up_todo_app/core/casheing/cache_helper.dart';

// ···
class LocalAuthHelper {
  static final _auth = LocalAuthentication();

  // ···
  static Future<void> enabledBiometric() async {
    await CacheHelper.setBool("biometric_enabled", true);
  }

  static Future<void> disabled() async {
    await CacheHelper.setBool("biometric_enabled", false);
  }

  static bool isBiometricEnabled() {
    return CacheHelper.getBool("biometric_enabled") ?? false;
  }

  ///=====PIN===
  static Future<void> setPin(String pin) async {
    await CacheHelper.setString("pin_code", pin);
  }

  static String getPin() {
    return CacheHelper.getString("pin_code") ?? "";
  }

  static Future<void> clearPin() async {
    await CacheHelper.remove("pin_code");
  }

  static Future<void> clearAll() async {
    await disabled();
    await clearPin();
  }

  static Future<bool> canCheckBiometrics() async {
    return await _auth.canCheckBiometrics;
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _auth.getAvailableBiometrics();
  }

  static Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: "Please Authenticate to proceed",
        options: AuthenticationOptions(stickyAuth: true),
      );
    } catch (e) {
      return false;
    }
  }
}
