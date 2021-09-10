import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData{
  final LatLng location;
  final String address;
  final bool isMocked;

  LocationData(this.location, this.address, this.isMocked);
}