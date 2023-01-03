import 'package:latlong2/latlong.dart';

class CurrentLocationModel{
  final String address;
  final LatLng latLng;

  CurrentLocationModel({
    required this.address,
    required this.latLng,
  });
}