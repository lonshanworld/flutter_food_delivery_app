import 'dart:convert';

import 'package:food_delivery_app/data/repos/auth_repo.dart';
import 'package:food_delivery_app/models/reponse_model.dart';
import 'package:food_delivery_app/models/signup_body.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async{
    _isLoading = true;
    update();
    http.Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    // print("all response in authController ${response.body}");
    // print("${response.statusCode}");
    // print("bodyBytes in authController ${response.statusCode}");

    if(response.statusCode == 200){
      var responsedata = json.decode(response.body);
      String idToken = responsedata["idToken"];
      String uid = responsedata["localId"];
      // print("uid in authcontroller $uid");
      // print("Token in authController $idToken");
      authRepo.saveUserToken(idToken);
      authRepo.saveUserId(uid);
      // authRepo.getUserId();
      responseModel = ResponseModel(true,idToken);
    }else{
      // print("TokenError in authController ${response.body}");
      responseModel = ResponseModel(false, response.statusCode.toString());
      // responseModel = ResponseModel(true, "aaa");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async{
    _isLoading = true;
    update();
    http.Response response = await authRepo.login(email,password);
    late ResponseModel responseModel;
    // print("all response in authController ${response.body}");
    // print("statusCode in authcontroller ${response.statusCode}");
    // print("bodyBytes in authController ${response.statusCode}");

    if(response.statusCode == 200){
      var responsedata = json.decode(response.body);
      String idToken = responsedata["idToken"];
      String uid = responsedata["localId"];
      // print("uid in authcontroller $uid");
      // print("Token in authController $idToken");
      authRepo.saveUserToken(idToken);
      authRepo.saveUserId(uid);
      // authRepo.getUserId();
      // final id = await authRepo.getUserId();
      // print("getuserId in authcontroller $id");
      responseModel = ResponseModel(true,idToken);
    }else{
      // print("TokenError in authController ${response.body}");
      responseModel = ResponseModel(false, response.statusCode.toString());
      // responseModel = ResponseModel(true, "aaa");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserEmailAndPassword(String email, String password) async{
    authRepo.saveUserEmailAndPassword(email, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }


}
