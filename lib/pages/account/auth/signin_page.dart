import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/show_custom_snackbar.dart';
import 'package:flutter_application_1/pages/account/auth/signup_page.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:flutter_application_1/weidgets/custom_circular_loader.dart';
import 'package:flutter_application_1/weidgets/small_text.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../weidgets/app_textfield.dart';
import '../../../weidgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var authController = Get.find<AuthController>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    //validation form function to validate on front end.
    _formValidationForLogin(AuthController authController) {
      //final String email = emailController.text.trim();
      final String phone = phoneController.text.trim();
      final String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackbar('Please enter your email address');
      } else if (password.isEmpty) {
        showCustomSnackbar('Please enter your password!');
      } else {
        // Get.snackbar('Successfull', 'All went well');
        authController.userLogin(phone, password).then((status) {
          if (status.isSuccess) {
            //User can only be login through his phone number & password.
            Get.toNamed(RouterHelper.initial);
            print('Login is succesfull!');
          } else {
            showCustomSnackbar(status.message);
            print('Something went wrong!');
            //TODO: Starts from here.
          }
        });
      }
    }

    return GetBuilder<AuthController>(builder: (authController) {
      return !authController.isLoading
          ? Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    //Image logo on the top
                    Container(
                      height: Dimensions.screenHeight * 0.30,
                      margin:
                          EdgeInsets.only(top: Dimensions.screenHeight * 0.05),
                      child: Center(
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/image/logo part 1.png"),
                          radius: Dimensions.radius30 * 4,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    //Heading for Hello welcome
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      height: Dimensions.screenHeight * 0.20,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          // color: Colors.redAccent
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: "Hello,",
                            size: Dimensions.font20 * 3 + Dimensions.font20 / 2,
                          ),
                          SmallText(
                            text: "W    e   l   c   o   m   e",
                            size: Dimensions.font26,
                          )
                        ],
                      ),
                    ),
                    //TextFields for email
                    AppTextfield(
                        textEditingController: phoneController,
                        hintText: "Phone No",
                        icons: Icons.email_rounded),
                    SizedBox(height: Dimensions.height20),
                    //Text Field for the Password.
                    AppTextfield(
                        textEditingController: passwordController,
                        hintText: "Password",
                        obscureTexts: true,
                        icons: Icons.password_rounded),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //Sign In Button
                    GestureDetector(
                      onTap: () {
                        print("Sign In Button Being Tapped!");
                        //Calling a validation fuction which we have created above.!
                        _formValidationForLogin(authController);
                      },
                      child: Container(
                        height: Dimensions.screenHeight * 0.09,
                        width: Dimensions.screenWidth * 0.40,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor),
                        child: Center(
                          child: BigText(
                            text: "Sign In",
                            color: Colors.white,
                            size: Dimensions.font26,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.02,
                    ),
                    //Clickable Text: Already have an account
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(
                                    SignUpPage(),
                                  ),
                            text: "Don't have an account,",
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                              color: Colors.grey[500],
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(
                                    SignUpPage(),
                                  ),
                            text: " Create?",
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : CustomCircularLoader();
    });
  }
}
