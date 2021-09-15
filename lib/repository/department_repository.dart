import 'package:movie_app/datasource/cache/service/user_dao.dart';
import 'package:movie_app/datasource/network/service/department_service.dart';
import 'package:movie_app/models/department.dart';
import 'package:movie_app/repository/response.dart';

class DepartmentRepository {

  final _departmentService = DepartmentService();
  final _userDao = UserDao();

  Future<Resource<List<Department>>> getAllDepartmentAndEmployees() async {
    try{
      final sessionId = await _userDao.getLastLoginUserSession();
      if(sessionId == null) return NotAuthorize();
      final departmentList = await _departmentService.getAllDepartmentAndEmployees(sessionId);
      return Success(data: departmentList);
    }catch(error){
      print("Error dengan $error");
      return Error(message: error.toString());
    }
  }

}