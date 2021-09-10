import 'package:movie_app/datasource/cache/service/UserDao.dart';
import 'package:movie_app/datasource/network/service/user_service.dart';
import 'package:movie_app/repository/response.dart';

class UserRepository {

  final _userService = UserService();
  final _userDao = UserDao();

  Future<Response<String>> login(String username, String password) async{
    try{
      final result = await _userService.login(username, password);
      await _userDao.login(result);
      return Success(data: "Berhasil Login");
    } on Exception catch(e){
      return Error(message: e.toString().split(": ").last);
    }catch(error){
      return Error(message: "Gagal login");
    }
  }

  Future<Response<String>> getLastLoggedInSessionId() async {
    final result = await _userDao.getLastLoginUserSession();
    return result == null ? NotAuthorize() :Success(data: "Berhasil Login");
  }

  Future<void> logout() async {
    _userDao.logout();
  }



}