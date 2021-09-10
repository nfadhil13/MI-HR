import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:movie_app/datasource/network/base_dto.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/datasource/network/error_extractor.dart';
import 'package:movie_app/datasource/network/mapper/department_mapper.dart';
import 'package:movie_app/datasource/network/models/department_dto.dart';
import 'package:movie_app/datasource/network/models/employee_post_dto.dart';
import 'package:movie_app/datasource/network/network_const.dart';
import 'package:movie_app/datasource/network/rpc_client.dart';
import 'package:movie_app/models/department.dart';

class EmployeeService {
  static final _employeeExtraURL = "/api/hr/employee";


  final httpClient = ClientWithLogger();

  String _constructURL(String endPoint) {
    return NetworkConst.baseURL + _employeeExtraURL + endPoint;
  }

  Future<void> addNewEmployee(String sessionId, String name, String email, int departmentId, XFile imageFile) async {
    try {
      final url = Uri.parse(_constructURL("/"));
      final postBody = await EmployeePostDto(name, email, departmentId, imageFile).toJson();
      final result = await httpClient.post(url,body: postBody, headers: {"Cookie": sessionId});
      final body = jsonDecode(result.body) as Map<String, dynamic>;
      print("berhasil kesini");
      body.forEach((key, value) {
        print("$key $value");
      });
      if(result.statusCode != 200){
        throw ApiError.createError(body);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
