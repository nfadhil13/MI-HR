import 'package:movie_app/datasource/cache/service/UserDao.dart';
import 'package:movie_app/datasource/network/error_extractor.dart';
import 'package:movie_app/datasource/network/service/absensi_service.dart';
import 'package:movie_app/models/absensi.dart';
import 'package:movie_app/repository/response.dart';

class AbsensiRepository {

  final _absensiService = AbsensiService();
  final _userDao = UserDao();

  Future<Response<List<Absensi>>> getAbsensiList() async {
    try{
      final sessionId = await _userDao.getLastLoginUserSession();
      if(sessionId == null) return NotAuthorize();
      final departmentList = await _absensiService.getAbsensiOfUser(sessionId);
      print("${departmentList[0].checkOut} ${departmentList[0].id}");
      return Success(data: departmentList);
    } on ApiError catch(error){
      return Error(message: error.errorMessage);
    }catch(error){
      print("Error dengan $error");
      return Error(message: error.toString());
    }
  }

  Future<Response<dynamic>> checkIn(double latitude, double longitude) async {
    try{
      final sessionId = await _userDao.getLastLoginUserSession();
      if(sessionId == null) return NotAuthorize();
      await _absensiService.checkIn(sessionId, latitude, longitude);
      return Success(data: null);
    } on ApiError catch(error){
      return Error(message: error.errorMessage);
    }catch(error){
      print("Error dengan $error");
      return Error(message: error.toString());
    }
  }

  Future<Response<dynamic>> checkOut(double latitude, double longitude) async {
    try{
      final sessionId = await _userDao.getLastLoginUserSession();
      if(sessionId == null) return NotAuthorize();
      await _absensiService.checkOut(sessionId, latitude, longitude);
      return Success(data: null);
    } on ApiError catch(error){
      return Error(message: error.errorMessage);
    }catch(error){
      print("Error dengan $error");
      return Error(message: error.toString());
    }
  }

}