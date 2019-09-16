import 'package:shared_preferences/shared_preferences.dart';

class AppSecurity {
  AppSecurity._internal();
  static AppSecurity _instance;

  static SharedPreferences prefs;

  static Future<AppSecurity> getInstance() async {
    if (_instance == null) {
      prefs = await SharedPreferences.getInstance();
      _instance = AppSecurity._internal();
    }
    return _instance;
  }
  
  Future<String> token() async {
    final token = prefs.getString("Token");
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
    print("hasToken");
    // write to keystore/keychain
    String token = await prefs.get("Token");
    print("SharedPreferences hasToken $token");
    if (token != null) {
      return token.isNotEmpty;
    } else {
      return false;
    }
  }

}