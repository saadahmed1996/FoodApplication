import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

void showCustomSnackbar(String message,
    {bool isError = true, String title = 'Error'}) {
  Get.snackbar(title, message,
      colorText: AppColors.whiteColor, backgroundColor: AppColors.redColor);
}

void showCustomSnackbarForPass(String message,
    {bool isSuccessfull = true, String title = 'Successfull'}) {
  Get.snackbar(title, message,
      colorText: AppColors.whiteColor, backgroundColor: AppColors.greenColor);
}
