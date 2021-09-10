import 'package:movie_app/datasource/network/models/employee_dto.dart';
import 'package:movie_app/models/employee.dart';

class DepartmentDto {
  final int id;
  final String name;
  List<EmployeeDto> employeeList = [];

  DepartmentDto(this.id, this.name, this.employeeList);

  static DepartmentDto fromJson(Map<String, dynamic> json) {
    return DepartmentDto(
      json["id"] as int,
      json["name"].toString(),
      (json["employees"] as List).map((e) => EmployeeDto.fromJson(e)).toList()
    );
  }

}