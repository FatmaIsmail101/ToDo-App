import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginService {
  static Future<Map<String, dynamic>?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        return userData;
      } else {
        print("Facebook login failed ${result.status}");
      }
    } catch (e) {
      print("Error during Facebook login : $e");
      return null;
    }
  }

  static Future<void> logOut() async {
    await FacebookAuth.instance.logOut();
  }
}
