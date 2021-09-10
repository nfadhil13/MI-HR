import 'dart:convert';

import 'package:movie_app/datasource/network/base_dto.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/datasource/network/error_extractor.dart';
import 'package:movie_app/datasource/network/mapper/department_mapper.dart';
import 'package:movie_app/datasource/network/models/department_dto.dart';
import 'package:movie_app/datasource/network/network_const.dart';
import 'package:movie_app/models/department.dart';
class DepartmentService {

  static final _departmentExtraURL = "/api/hr/department";

  final _departmentMapper = DeparmentMapper();

  String _constructURL(String endPoint){
    return NetworkConst.baseURL + _departmentExtraURL + endPoint;
  }

  Future<List<Department>> getAllDepartmentAndEmployees(String sessionId) async{
    try{
      final url = Uri.parse(_constructURL("/employee"));
      final result = await http.get(url,headers: {
        "Cookie" : sessionId
      });
      final body = jsonDecode(result.body) as Map<String,dynamic>;
      if(result.statusCode == 200 && body.containsKey("result")){
        final result = body["result"] as List;
        return result.map((e){
          print(e);
          return _departmentMapper.mapToDomain(DepartmentDto.fromJson(e));
        }).toList();
      }else {
        throw ApiError.createError(body);
      }

    }catch(error) {
      throw error;
    }
  }

}