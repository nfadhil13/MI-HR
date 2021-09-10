import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_app/datasource/mapper.dart';
import 'package:movie_app/datasource/network/models/absensi_dto.dart';
import 'package:movie_app/models/absensi.dart';

class AbsensiMapper extends OneWay<AbsensiDto, Absensi>  {


  @override
  Absensi mapToDomain(AbsensiDto input) {
    return Absensi(
        id: input.id,
        checkIn: input.checkIn,
        checkOut: input.checkOut,
        workHours: input.workedHours,
        checkInCoordinates: LatLng(input.latIn, input.longIn),
        checkOutCoordinates: LatLng(input.latIn , input.longIn)
    );
  }

}