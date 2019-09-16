
import 'package:shared_preferences/shared_preferences.dart';

class AppSecurity {
  static var shared = AppSecurity();

  SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }
  
  Future<String> token() async {
    final token = await prefs.getString("Token");
    return token;
  }

  Future<void> deleteToken() async {
    await prefs.remove("Token");
    return;
  }

  Future<void> persistToken(String token) async {
    // write to keystore/keychain
    await prefs.setString("Token", token);
    return;
  }

  Future<bool> hasToken() async {
    // write to keystore/keychain
    String token = prefs.get("Token");
    print("SharedPreferences hasToken $token");
    if (token != null) {
      return token.isNotEmpty;
    } else {
      return false;
    }
  }

}