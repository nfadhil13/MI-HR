import 'package:movie_app/datasource/JSONParser.dart';

class AbsensiDto {
  AbsensiDto({
    required this.id,
    required this.employeeId,
    required this.checkIn,
    required this.checkOut,
    required this.workedHours,
    required this.latIn,
    required this.longIn,
    required this.latOut,
    required this.longOut,
  });

  int id;
  int employeeId;
  DateTime? checkIn;
  DateTime? checkOut;
  double workedHours;
  double latIn;
  double longIn;
  double latOut;
  double longOut;

  factory AbsensiDto.fromJson(Map<String, dynamic> json){
    final checkInTime = SafeCaster.tryCast<dynamic,bool>(json["check_in"]);
    final checkOutTime = SafeCaster.tryCast<dynamic,bool>(json["check_out"]);
    return  AbsensiDto(
      id: json["id"],
      employeeId: json["employee_id"],
      checkIn: checkInTime == null ? DateTime.parse(json["check_in"]) : null,
      checkOut: checkOutTime == null ? DateTime.parse(json["check_in"]) : null,
      workedHours: json["worked_hours"],
      latIn: json["lat_in"],
      longIn: json["long_in"],
      latOut: json["lat_out"],
      longOut: json["long_out"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "check_in": checkIn?.toIso8601String() ?? "0",
    "check_out": checkOut?.toIso8601String() ?? "0",
    "worked_hours": workedHours,
    "lat_in": latIn,
    "long_in": longIn,
    "lat_out": latOut,
    "long_out": longOut,
  };
}
