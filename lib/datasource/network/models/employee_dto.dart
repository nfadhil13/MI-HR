import 'package:movie_app/datasource/JSONParser.dart';

class EmployeeDto {
  final int id;
  final String name;
  final String email;
  final String position;
  final String imageURL;

  EmployeeDto({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    required this.imageURL});


  static EmployeeDto fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
        id: json["id"],
        name: json["name"],
        email: SafeCaster.tryCastAndDefault<dynamic, String>(json["email"],"Email unknown"),
        position: SafeCaster.tryCastAndDefault<dynamic, String>(json["position"], "Position not assigned"),
        imageURL: json["image"]
    );
  }
}
