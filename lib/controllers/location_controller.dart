import 'package:food_delivery_app/data/repos/location_repo.dart';
import 'package:food_delivery_app/global_base/show_custom_message.dart';
import 'package:food_delivery_app/models/currentLocation_model.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService{
  final LocationRepo locationRepo;
  LocationController({
    required this.locationRepo,
  });

  bool _loading = false;
  bool get loading => _loading;
  // late Position _position;
  // late Position _pickPosition;
  late Placemark _placemark;
  Placemark get placeMark => _placemark;

  List<AddressModel>? _deliAddressList = [];
  List<AddressModel> get deliAddressList => _deliAddressList!;

  Future<String> getAddressfromGeocode(LatLng latLng)async{
    _loading = true;
    update();
    try{
      Placemark address = await locationRepo.getAddressfromGeocode(latLng.latitude,latLng.longitude);
      _placemark = address;
      _loading =false;
      update();
      // print("address from locaton controller $address");
      // print("location controller ${address.street} , ${address.locality} , ${address.country}");
      return "${address.street} , ${address.locality} , ${address.country}";
    }catch(err){
      // print(err);
      _loading =false;
      update();
      return "$err";
    }
  }

  Future<LatLng> getGeocodeFromAddress(String address)async{
    _loading = true;
    update();
    try{
      Location location = await locationRepo.getGeocodeFromAddress(address);

      _loading =false;
      update();
      return LatLng(location.latitude, location.longitude);
    }catch(err){
      _loading =false;
      update();
      rethrow;
    }
  }

  Future<void>saveLocationAndInfo({required String address, required String name, required String phone, required LatLng latLng})async{
    _loading = true;
    update();
    try{
      AddressModel addressModel = AddressModel(
        contactPersonName: name,
        contactPersonNumber: phone,
        address: address,
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      );
      _deliAddressList = [addressModel];

      await locationRepo.saveLocationAndInfo(addressModel);
      _loading = false;
      update();
      showCustomSnackbar(
        "Address and Infos are successfully saved",
        title: "Saved",
        isError: false,
      );

    }catch(err){
      // print(err);
      _loading = false;
      update();
    }
  }

  Future<void> getDelilocation()async{
    _loading = true;
    update();
    try{
      AddressModel _infofromFb = await locationRepo.getDelilocation();
      _deliAddressList = [_infofromFb];
      // print("_deliAddressList in location controller ${_deliAddressList![0].address}");
      _loading = false;
      update();
    }catch(err){
      // print(err);
      _loading = false;
      update();
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showCustomSnackbar(
        "Location services are disabled. Please enable the services.",
        title: "Location Permission Denied",
        isError: true,
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showCustomSnackbar(
          "Location services are disabled. Please enable the services.",
          title: "Location Permission Denied",
          isError: true,
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showCustomSnackbar(
        "Location permissions are permanently denied, we cannot request permissions.",
        title: "Location Permission Permanently Denied",
        isError: true,
      );
      return false;
    }
    return true;
  }

  Future<Position> getLocal()async{
    try{
      final hasPermission = await _handleLocationPermission();
      if(hasPermission){
        Position info = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        return info;
      }else{
        return Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0);
      }
    }catch(err){
      showCustomSnackbar(
        "Location not found",
        title: "Location not found",
        isError: true,
      );
      rethrow;
    }
  }


  Future<CurrentLocationModel>getUserCurrentLocation()async{
    _loading = true;
    update();
    try{
      Position currinfo = await getLocal();
      Placemark localinfotext = await locationRepo.getAddressfromGeocode(currinfo.latitude,currinfo.longitude);

      CurrentLocationModel currentLocationModel = CurrentLocationModel(
        address: "${localinfotext.street} , ${localinfotext.locality} , ${localinfotext.country}",
        latLng: LatLng(currinfo.latitude, currinfo.longitude),
      );
      // return fulladdress;
      _loading = false;
      update();
      return currentLocationModel;
    }catch (err){
      // print("current location err $err");

      _loading = false;
      update();
      rethrow;
    }
  }



}