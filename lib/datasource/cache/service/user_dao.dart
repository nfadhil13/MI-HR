
import 'package:hive/hive.dart';
import 'package:movie_app/datasource/cache/local_storage.dart';
import 'package:movie_app/datasource/cache/model/user_entity.dart';
import 'package:movie_app/models/user.dart';

class UserDao{

  final _localStorage = LocalStorage();
  static final sessionIdKey = "HR_APP_SESSION_ID_KEY";

  Future<void> login(String sessionId, User user) async{
    await _localStorage.secureStorage.write(key: sessionIdKey, value: sessionId);
    final  box = await Hive.openBox<UserEntity>(UserEntity.boxName);
    await box.put(user.id, UserEntity(user.id, user.name, user.jobTitle, user.imageProfileURL, user.isImageFromURL));
    await box.close();
  }


  Future<User?> updateUserById(User user) async {
    final  box = await Hive.openBox<UserEntity>(UserEntity.boxName);
    final getLastUser = box.get(user.id);
    if(getLastUser != null){
      return User(
          id: getLastUser.id,
          name: getLastUser.name,
          jobTitle: getLastUser.jobTitle,
          imageProfileURL: getLastUser.imageProfileURL,
          isImageFromURL: getLastUser.isImageFromURL
      );
    }
    return null;
  }

  Future<User?> getLastUser() async {
    final  box = await Hive.openBox<UserEntity>(UserEntity.boxName);
    final getLastUser = box.getAt(box.length);
    await Hive.close();
    if(getLastUser != null){
      return User(
          id: getLastUser.id,
          name: getLastUser.name,
          jobTitle: getLastUser.jobTitle,
          imageProfileURL: getLastUser.imageProfileURL,
          isImageFromURL: getLastUser.isImageFromURL
      );
    }
    return null;
  }
  Future<String?> getLastLoginUserSession() async {
    return await _localStorage.secureStorage.read(key: sessionIdKey);
  }

  
  Future<void> logout() async {
    await _localStorage.secureStorage.delete(key: sessionIdKey);
    final  box = await Hive.openBox<UserEntity>(UserEntity.boxName);
    if(box.isNotEmpty){
      await box.clear();
    }
    await Hive.close();
  }
}