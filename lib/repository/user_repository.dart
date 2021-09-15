import 'package:movie_app/datasource/cache/service/user_dao.dart';
import 'package:movie_app/datasource/network/error_extractor.dart';
import 'package:movie_app/datasource/network/service/user_service.dart';
import 'package:movie_app/models/user.dart';
import 'package:movie_app/repository/response.dart';
import 'package:movie_app/util/connectivity_checker.dart';

class UserRepository {

  final _userService = UserService();
  final _userDao = UserDao();
  final _networkChecker = ConnectivityChecker();
  Future<Resource<String>> login(String username, String password) async{
    try{
      final result = await _userService.login(username, password);
      final user = await _userService.getUserProfile(result);
      await _userDao.login(result, user);
      return Success(data: "Berhasil Login");
    } on Exception catch(e){
      return Error(message: e.toString().split(": ").last);
    }catch(error){
      return Error(message: "Gagal login");
    }
  }

  Future<Resource<String>> getLastLoggedInSessionId() async {
    final result = await _userDao.getLastLoginUserSession();
    return result == null ? NotAuthorize() :Success(data: "Berhasil Login");
  }


  Future<Resource<User>> getUserProfile() async {
    return _networkChecker.connectivityCall<Resource<User>>(() async {
      try{
        final sessionId = await _userDao.getLastLoginUserSession();
        if(sessionId == null) return NotAuthorize();
        final userFromNetwork = await _userService.getUserProfile(sessionId);
        await _userDao.updateUserById(userFromNetwork);
        return Success(data: userFromNetwork);
      }on ApiError catch(e){
        return Error(message: e.errorMessage);
      }catch(error){
        return Error(message: "Gagal mendapatkan profile user");
      }
    }, () async {
      try{
        final lastUserFromCachce = await _userDao.getLastUser();
        if(lastUserFromCachce == null) return NotAuthorize();
        return Success(data: lastUserFromCachce);
      }catch(error){
        return Error(message: "Gagal mendapatkan profile user");
      }
    });

  }

  Future<void> logout() async {
    _userDao.logout();
  }



}