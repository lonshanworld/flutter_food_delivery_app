import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/models/signup_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "package:http/http.dart" as http;

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<http.Response> registration(SignUpBody signUpBody)async{
    // await apiClient.postData(AppConstants.REGISTRATION_TESTING, signUpBody.toJson());
    // print("auth repo ${signUpBody}");
    final response = await apiClient.postData(AppConstants.REGISTRATION_SIGNUP_URI, signUpBody.email,signUpBody.password);
    await  apiClient.postUserInfo(AppConstants.REGISTRATION_TESTING,signUpBody, apiClient.uid);

    return response;
  }

  Future<http.Response> login(String email, String password)async{
    // await apiClient.postData(AppConstants.REGISTRATION_TESTING, signUpBody.toJson());
    // print("auth repo ${signUpBody}");
    final response = await apiClient.postData(AppConstants.REGISTRATION_SIGNIN_URI, email,password);
    // await  apiClient.postUserInfo(AppConstants.REGISTRATION_TESTING,signUpBody, apiClient.uid);
    // print("response in auth_repo $response");

    return response;
  }


  Future<bool>saveUserToken(String token) async{
    // print("Saveuserid in authrepo $uid");
    apiClient.token = token;
    // apiClient.updateHeader(token);
    // await sharedPreferences.setString(AppConstants.USER_ID, apiClient.uid);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<bool>saveUserId(String uid) async{
    // print("Saveuserid in authrepo $uid");
    // print("saveuserid $uid");

    return await sharedPreferences.setString(AppConstants.USER_ID, uid);
  }

  // Future<String> getUserId() async{
  //   final uid = await sharedPreferences.getString(AppConstants.USER_ID);
  //   apiClient.setUid(uid!);
  //   return uid;
  // }

  Future<String> getUserToken() async{
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  // Future<String> getUserId() async{
  //   return await sharedPreferences.getString(AppConstants.USER_ID) ?? "None";
  // }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }


  Future<void> saveUserEmailAndPassword(String email, String password) async{
    try{
      await sharedPreferences.setString(AppConstants.EMAIL, email);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(err){
      // print("ERR $err");
      rethrow;
    }
  }

  bool clearSharedData(){
    try{
      sharedPreferences.remove(AppConstants.TOKEN);
      sharedPreferences.remove(AppConstants.EMAIL);
      sharedPreferences.remove(AppConstants.PASSWORD);
      sharedPreferences.remove(AppConstants.USER_ID);
      apiClient.token = "";
      // apiClient.updateHeader("");
      apiClient.clearUid();
      return true;
    }catch(err){
      return false;
    }
  }


}