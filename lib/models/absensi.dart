import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class Absensi {
  final int id;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final double workHours;
  final LatLng checkInCoordinates;
  final LatLng checkOutCoordinates;

  Absensi({
  required this.id, this.checkIn, this.checkOut, required this.workHours,
  required this.checkInCoordinates, required this.checkOutCoordinates
  });


  String _getTimeHour(DateTime? dateTime) {
    return dateTime == null ? "--:--"  : DateFormat.Hm().format(dateTime);
  }

  String getCheckInHour() {
    return _getTimeHour(checkIn);
  }

  String getCheckoutHour() {
    return _getTimeHour(checkOut);
  }


}