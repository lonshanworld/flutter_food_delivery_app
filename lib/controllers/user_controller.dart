import 'dart:convert';
import 'package:food_delivery_app/data/repos/user_repo.dart';
import 'package:food_delivery_app/models/reponse_model.dart';
import 'package:food_delivery_app/models/user_model.dart';

import 'package:get/get.dart' as GET;
import "package:http/http.dart" as http;

class UserController extends GET.GetxController implements GET.GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  UserModel? _userModel;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async{
    http.Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;

    if(response.statusCode == 200){
      // print("Success in userController");
      // _userModel = UserModel.fromJson(response.body);

      final extracteddata = json.decode(response.body)as Map<String,dynamic>;

      final List<UserModel> loadedUserInfo = [];

      extracteddata.forEach((key, value) {

        loadedUserInfo.add(
            UserModel(
              id: value["Userid"],
              name: value["f_name"],
              email: value["email"],
              phone: value["phone"],
              orderCount: value["order_count"],
            ));
      });
      // userRepo.saveUserKey(keys[0]);
      _userModel = loadedUserInfo[0];
      // print("usermodel $_userModel");
      _isLoading = true;
      // print("_userModel in userController $_userModel");
      responseModel = ResponseModel(true,"successfully");
    }else{
      // print("TokenError in authController ${response.body}");
      // print("Fail in userController");
      responseModel = ResponseModel(false, response.statusCode.toString());
      // responseModel = ResponseModel(true, "aaa");
    }

    update();
    return responseModel;
  }

}
