import 'package:movie_app/models/employee.dart';

class Department {
  final int id;
  final String name;
  final List<Employee> employees;

  Department({required this.id, required this.name, required this.employees});

  String get description {
    return "Deparment that responsible for ${this.name}";
  }

}