import 'package:image_picker/image_picker.dart';
import 'package:movie_app/datasource/cache/service/user_dao.dart';
import 'package:movie_app/datasource/network/error_extractor.dart';
import 'package:movie_app/datasource/network/service/employee_service.dart';
import 'package:movie_app/repository/response.dart';

class EmployeeRepository {
  final employeeService = EmployeeService();
  final userDao = UserDao();

  Future<Resource<String>> addNewEmployee(
      String name, String email, XFile image, int departmentId) async {
    try {
      final sessionId = await userDao.getLastLoginUserSession();
      if (sessionId == null) return NotAuthorize();
      await employeeService.addNewEmployee(
          sessionId, name, email, departmentId, image);
      return Success(data: "Creating new Employee Success");
    } on ApiError catch (error) {
      return Error(message: error.errorMessage);
    } catch (error) {
      return Error(message: "Unknown Error");
    }
  }

  
}
