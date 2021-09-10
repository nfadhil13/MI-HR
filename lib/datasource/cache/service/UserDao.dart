
import 'package:movie_app/datasource/cache/local_storage.dart';

class UserDao{

  final _localStorage = LocalStorage();
  static final sessionIdKey = "HR_APP_SESSION_ID_KEY";

  Future<void> login(String sessionId) async{
    await _localStorage.secureStorage.write(key: sessionIdKey, value: sessionId);
  }

  Future<String?> getLastLoginUserSession() async {
    return await _localStorage.secureStorage.read(key: sessionIdKey);
  }

  
  Future<void> logout() async {
    await _localStorage.secureStorage.delete(key: sessionIdKey);
  }
}