import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  setUserRole(String role) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('role', role);
  }

  Future<String> getUserRole(String role) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(role);
  }
}
