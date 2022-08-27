import 'package:flutter_application_1/data/api/api_client.dart';
import 'package:flutter_application_1/models/user_data_model.dart';
import 'package:flutter_application_1/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  //User Registration Repo
  Future<Response> userRegister(UserDataModel userDataModel) async {
    Response response = await apiClient.postData(
        AppConstants.REGISTRATION_URI, userDataModel.toJson());
    return response;
  }

  //User Login Repo.
  Future<Response> userLogin(String phone, String password) async {
    Response response = await apiClient.postData(
        AppConstants.LOGIN_URI, {'phone': phone, 'password': password});
    //Right above we are converting objects into json format, No need to create a model because it has only two fields.
    return response;
  }

  //Saving credentials in a sharedpreference locally in the device.
  Future<bool> saveUserData(String token) async {
    apiClient.token = token;
    apiClient.updateHeaders(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  //Saving phone and password locally in device with the help of shared preferences.
  Future<void> saveUserPhoneAndPassword(String phone, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, phone);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  //Get the user Token
  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  //Checking if the user is logged in by matching token key.
  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  //Clearing data from local device, When User logout.
  bool clearSharedPreferences() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PHONE);
    sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token = '';
    apiClient.updateHeaders('');
    return true;
  }

  // Future<bool> clearSharedPreferences() async {
  //   return await sharedPreferences.clear();
  // }
}
