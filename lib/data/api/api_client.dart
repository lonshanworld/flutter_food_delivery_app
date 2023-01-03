import 'dart:convert';

import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/models/signup_body.dart';
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  // late Map<String,String> _mainHeaders;
  late SharedPreferences sharedPreferences;
  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    // _mainHeaders = {
    //   "Content-type":"application/json; charset=UTF-8",
    //   "Authorization" : "Bearer $token",
    //   "HttpHeaders.contentTypeHeader": "application/json"
    // };
  }

  late String _uid;
  // late SharedPreferences sharedPreferences;

  void setUid(String uid){
    _uid = uid;
  }

  String get uid => _uid;


  void clearUid(){
    _uid = "";
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async{
    try{
      Response response = await get(uri);
      // print("response in apiclient getdata ${response.body}");
      return response;
    }catch(e){
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<http.Response> getUserInfo(String uri, String aabb) async{
    final url = Uri.parse("$uri$aabb.json");
    // print("url $url");
    try{
      // Response response = await get("$uri$Uid.json");
      // print("response in apiclient getUserInfo ${response.body}");
      // print("responsedata in apiclient getUserInfo ${responsedata.body}");
      final response = await http.get(url);

      return response;
    }catch(e){
      return http.Response(
          e.toString(), 1,
      );
    }
  }

  // void updateHeader(String token){
  //   _mainHeaders = {
  //     "Content-type":"application/json; charset=UTF-8",
  //     "Authorization" : "Bearer $token",
  //     "HttpHeaders.contentTypeHeader": "application/json"
  //   };
  // }

  Future<http.Response>postData(String uri, String email, String password)async{
    // FirebaseAuth auth = FirebaseAuth.instance;
    try{

      final url = Uri.parse(uri);
      final response = await http.post(url,body: json.encode({
        "email" : email,
        "password" : password,
        "returnSecureToken": true,
      })
      );

      if(response.statusCode == 200){
        final responsedata = json.decode(response.body);
        _uid = responsedata["localId"];
        // await sharedPreferences.setString(AppConstants.USER_ID, _uid);

      }

      return response;
    }catch(err){
      return http.Response("Something is wrong. Please try again",1);
    }
  }

  Future<void> postUserInfo(String uri, SignUpBody body, String id)async {
    final url = Uri.parse("$uri$id.json");
    try{
      await http.post(url, body: json.encode({
        "f_name" : body.name,
        "email" : body.email,
        "password" : body.password,
        "phone" : body.phone,
        "created_at" : DateTime.now().toString(),
        "Userid" : _uid,
        "order_count" : 0,
      }));
      // final responsedata = json.decode(response.body);
      // final keyname = responsedata;
      // AppConstants.KEY_NAME = responsedata;

    }catch(err){
      // print("for storage err $err");
      rethrow;
    }
  }

  Future<http.Response> saveDeliveryInfo(String uri, AddressModel addressModel, String uid)async{
    final url = Uri.parse("$uri$uid.json");
    try{
      final response = await http.post(url,body: json.encode({
        "contactPersonName" : addressModel.contactPersonName,
        "contactPersonPhone" : addressModel.contactPersonNumber,
        "Deliaddress" : addressModel.address,
        "latitude" : addressModel.latitude,
        "longitude" : addressModel.longitude,
      }));

      return response;
    }catch(err){
      // print("err in saveDeliInfo $err");
      rethrow;
    }
  }

  Future<http.Response>getDelilocation(String uri, String id)async{
    final url = Uri.parse("$uri$id.json");
    // print("url in delocation $url");
    try{
      http.Response response = await http.get(url);
      // print("response in delilocation ${response.body}");
      return response;
    }catch(err){
      // print("err $err");
      rethrow;
    }
  }
}