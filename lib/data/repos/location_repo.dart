import 'dart:convert';

import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:food_delivery_app/global_base/show_custom_message.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:geocoding/geocoding.dart';
import "package:shared_preferences/shared_preferences.dart";
import "package:http/http.dart" as http;

import '../api/api_client.dart';


class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Placemark>getAddressfromGeocode(double latitude, double longitude)async{
    List<Placemark> placeList=[];
    try{
      placeList = await placemarkFromCoordinates(latitude,longitude);
      Placemark place = placeList[0];
      return place;
    }catch(err){
      // print("err $err");
      rethrow;
    }
  }

  Future<Location>getGeocodeFromAddress(String address)async{

    try{
      List<Location> location = await locationFromAddress(address);
      Location oneLocation = location[0];
      return oneLocation;
    }catch(err){
      showCustomSnackbar("Location not found", title: "Lcation",isError: true);
      rethrow;
    }
  }

  Future<void>saveLocationAndInfo(AddressModel addressModel)async{
    String userId = sharedPreferences.getString(AppConstants.USER_ID)!;

    await apiClient.saveDeliveryInfo(AppConstants.DELI_INFO,addressModel,userId);
  }

  Future<AddressModel>getDelilocation() async{
    String uId = sharedPreferences.getString(AppConstants.USER_ID)!;
    // print("uid in locationrepo $uId");
    final AddressModel oneAddressModel;
    http.Response response = await apiClient.getDelilocation(AppConstants.DELI_INFO,uId);

    final extractedData = json.decode(response.body) as Map<String,dynamic>;
    // print("extractedData in locationrepo $extractedData");
    List<AddressModel> loadedData = [];

    extractedData.forEach((key, value) {
      loadedData.add(AddressModel(
        contactPersonName: value["contactPersonName"],
        contactPersonNumber: value["contactPersonPhone"],
        address: value["Deliaddress"],
        latitude: value["latitude"],
        longitude: value["longitude"],
      ));
    });
    final int index = loadedData.length;
    oneAddressModel = loadedData[index - 1];
    // print("Oneaddress model in location_repo ${oneAddressModel.address}");
    return oneAddressModel;
  }

}