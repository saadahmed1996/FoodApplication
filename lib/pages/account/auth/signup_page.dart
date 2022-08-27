import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/base/show_custom_snackbar.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/models/response_model.dart';
import 'package:flutter_application_1/models/user_data_model.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/weidgets/app_textfield.dart';
import 'package:flutter_application_1/weidgets/big_text.dart';
import 'package:flutter_application_1/weidgets/small_text.dart';
import 'package:get/get.dart';

import '../../../weidgets/custom_circular_loader.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Creating a instant to call register method.
    var authController = Get.find<AuthController>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    //List of images for bottom icons
    var signUpImages = [
      "f.png",
      "g.png",
      "t.png",
    ];

    //Validation form before proceeding further pass through this validation form.
    _formValidationForRegistration() {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String name = nameController.text.trim();
      final String phone = phoneController.text.trim();

      if (email.isEmpty) {
        showCustomSnackbar('Please enter your email address!');
      } else if (password.isEmpty) {
        showCustomSnackbar('Please enter your Password!');
      } else if (password.length < 6) {
        showCustomSnackbar(
            'Please enter your Password atleast 6 words longer!');
      } else if (name.isEmpty) {
        showCustomSnackbar('Please enter your name!');
      } else if (phone.isEmpty) {
        showCustomSnackbar('Please enter your phone no');
      } else {
        final UserDataModel userDataModel = new UserDataModel(
            email: email, password: password, name: name, phone: phone);
        // print(userDataModel.toString());

        authController.userRegistration(userDataModel).then((status) {
          if (status.isSuccess) {
            print('Registration is succesfull!');
            Get.offNamed(RouterHelper.getInitial());
          } else {
            showCustomSnackbar(status.message);
            print('Something went wrong!');
            //TODO: Starts from here.
          }
        });
      }
    }

    return GetBuilder<AuthController>(builder: (_authController) {
      return !_authController.isLoading
          ? SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Column(
                    children: [
                      //Image logo on the top
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/image/logo part 1.png"),
                            radius: Dimensions.radius20 * 4,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      //TextFields for Email
                      AppTextfield(
                          textEditingController: emailController,
                          hintText: "Email",
                          icons: Icons.email_outlined),
                      SizedBox(height: Dimensions.height20),
                      //Text Field for the Password.
                      AppTextfield(
                          textEditingController: passwordController,
                          hintText: "Password",
                          obscureTexts: true,
                          icons: Icons.password_rounded),
                      SizedBox(height: Dimensions.height20),
                      //Text Field for the Name.
                      AppTextfield(
                          textEditingController: nameController,
                          hintText: "Name",
                          icons: Icons.person_rounded),
                      SizedBox(height: Dimensions.height20),
                      //Text Field for the Phone.
                      AppTextfield(
                          textEditingController: phoneController,
                          hintText: "Phone No",
                          icons: Icons.phone_rounded),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //Sign Up Button
                      GestureDetector(
                        onTap: () {
                          // print("Sign Up Button Being Tapped!");
                          _formValidationForRegistration();
                          //Here auth controller will be initialized and get the registration method.
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
                              text: "Sign Up",
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "You Already have an account?",
                            style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.03,
                      ),
                      //Small text for user to tell that he/she can sign up using other methods.
                      SmallText(
                        text: "You can also sign up.",
                        size: Dimensions.font16 * 2 / 1.5,
                        color: Colors.grey[500],
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.001,
                      ),
                      //Wrap list to generate Bottom sign up icons
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: EdgeInsets.all(Dimensions.height20),
                            child: CircleAvatar(
                              radius: Dimensions.radius30 / 1.5,
                              backgroundImage: AssetImage(
                                "assets/image/" + signUpImages[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const CustomCircularLoader();
    });
  }
}
