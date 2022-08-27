import 'package:flutter_application_1/data/repository/auth_repo.dart';
import 'package:flutter_application_1/models/response_model.dart';
import 'package:flutter_application_1/models/user_data_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //User Registration Method.
  Future<ResponseModel> userRegistration(UserDataModel userDataModel) async {
    final ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await authRepo.userRegister(userDataModel);
    if (response.statusCode == 200) {
      authRepo.saveUserData(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //User Login Method.
  Future<ResponseModel> userLogin(String phone, String password) async {
    final ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await authRepo.userLogin(phone, password);
    if (response.statusCode == 200) {
      authRepo.saveUserData(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //Calling method from auth repo
  Future<void> saveUserPhoneAndPassword(String phone, String password) async {
    authRepo.saveUserPhoneAndPassword(phone, password);
  }

  //Calling method from auth repo
  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  //Calling method from auth repo.
  bool clearSharedPreferences() {
    return authRepo.clearSharedPreferences();
  }

  // Future<bool> clearSharedPreferences() {
  //   update();
  //   return authRepo.clearSharedPreferences();
  // }
}
