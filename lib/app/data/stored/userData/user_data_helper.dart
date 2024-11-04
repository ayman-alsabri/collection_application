import 'package:shared_preferences/shared_preferences.dart';

class UserDataHelper {
  final _name = 'userName';
  final _points = 'points';

  factory UserDataHelper() => _instance;
  static final _instance = UserDataHelper._intrnal();
  UserDataHelper._intrnal();

  static SharedPreferences? _prefs;
  Future<SharedPreferences> get prefs async =>
      _prefs ?? await SharedPreferences.getInstance();

  Future<bool> storeUserName(String userName) async {
    return (await prefs).setString(_name, userName);
  }

  Future<String?> getUserName() async {
    return (await prefs).getString(_name);
  }

  Future<bool> addPoints(int points) async {
    final previousPoints = (await prefs).getInt(_points) ?? 0;
    return (await prefs).setInt(_points, previousPoints + points);
  }

  Future<int> getPoints() async {
    return (await prefs).getInt(_points)??0;
  }
}
