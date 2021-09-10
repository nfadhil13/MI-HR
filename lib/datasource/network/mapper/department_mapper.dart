import 'package:movie_app/datasource/mapper.dart';
import 'package:movie_app/datasource/network/models/department_dto.dart';
import 'package:movie_app/models/department.dart';

import 'employee_mapper.dart';

class DeparmentMapper extends OneWay<DepartmentDto, Department> {
  
  final employeeMapper = EmployeeMapper();
  
  @override
  Department mapToDomain(DepartmentDto input) {
    return Department(id: input.id, name: input.name, employees: input.employeeList.map((e) => employeeMapper.mapToDomain(e)).toList());
  }
  
}