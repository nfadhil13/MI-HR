import 'package:movie_app/datasource/mapper.dart';
import 'package:movie_app/datasource/network/models/employee_dto.dart';
import 'package:movie_app/models/employee.dart';

class EmployeeMapper extends OneWay<EmployeeDto, Employee> {
  @override
  Employee mapToDomain(EmployeeDto input) {
    return Employee(id: input.id, email: input.email, name: input.name, position: input.position, imageURL: input.imageURL);
  }

}