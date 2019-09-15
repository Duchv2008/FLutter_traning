
import 'package:shared_preferences/shared_preferences.dart';

class AppSecurity {
  static var shared = AppSecurity();

  SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("Token");
    return;
  }

  Future<void> persistToken(String token) async {
    // write to keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Token", token);
    return;
  }

  Future<bool> hasToken() async {
    // write to keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("Token");
    print("SharedPreferences hasToken $token");
    if (token != null) {
      return token.isNotEmpty;
    } else {
      return false;
    }
  }

}