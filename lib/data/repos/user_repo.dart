
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_constants.dart';
import '../api/api_client.dart';
import "package:http/http.dart" as http;

class UserRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo({required this.apiClient,required this.sharedPreferences});

  Future<http.Response>getUserInfo() async{

    final uid = sharedPreferences.getString(AppConstants.USER_ID)!;
    return await apiClient.getUserInfo(AppConstants.REGISTRATION_TESTING, uid);
  }

}