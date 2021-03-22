import 'package:learn_blockchain/model/database/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Database store using shared preference
class DatabasePreferenceProvider implements Database<String> {
  @override
  Future<List<String>?> readAllFromDB() {
    throw UnimplementedError();
  }

  @override
  Future<String?> readFromDB(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  @override
  Future<void> writeToDB(key, String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, data);
  }

  @override
  Future<void> updateDB(key, String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, data);
  }
}
