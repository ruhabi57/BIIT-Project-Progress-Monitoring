import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class DataSharedPreferences {
  final userKey = 'UserKey';

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setUserData(String userData) async {
    if (prefs == null) {
      await initSharedPreferences();
    }
    await prefs!.setString(userKey, userData);
  }

  Future<String> getUserData() async {
    if (prefs == null) {
      await initSharedPreferences();
    }
    return prefs!.getString(userKey) ?? '';
  }
}
