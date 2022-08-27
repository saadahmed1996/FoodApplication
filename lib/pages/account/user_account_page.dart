import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/base/show_custom_snackbar.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:flutter_application_1/controllers/user_controller.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/weidgets/app_icon.dart';
import 'package:flutter_application_1/weidgets/big_text.dart';
import 'package:flutter_application_1/weidgets/custom_circular_loader.dart';
import 'package:get/get.dart';
import '../../controllers/location_controller.dart';
import '../../weidgets/account_appicon_text_widget.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "User Profile",
          size: Dimensions.font20,
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Column(
                    children: [
                      //For user profile image
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20),
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/image/profile_bg.png"),
                            radius: Dimensions.height45 * 2,
                          ),
                        ),
                      ),
                      //User Info (name,phone no etc..)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: Dimensions.height30),
                              //Name
                              AccountAppIconTextWidget(
                                bigText: BigText(
                                    text: userController.userModel.name),
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.iconSize24,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //Phone No
                              AccountAppIconTextWidget(
                                bigText: BigText(
                                    text: userController.userModel.phone),
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.iconSize24,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //Email
                              AccountAppIconTextWidget(
                                bigText: BigText(
                                    text: userController.userModel.email),
                                appIcon: AppIcon(
                                  icon: Icons.mail,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.iconSize24,
                                  backgroundColor: AppColors.iconColor1,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //Email Address
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    // cartController.addToHistory();
                                    if (Get.find<LocationController>()
                                        .addressList
                                        .isEmpty) {
                                      Get.toNamed(RouterHelper.getAddressPage());

                                    }
                                  }
                                },
                                child: AccountAppIconTextWidget(
                                  bigText: BigText(text: "Tap here to add your address"),
                                  appIcon: AppIcon(
                                    icon: Icons.location_on,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.iconSize24,
                                    backgroundColor: AppColors.signColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //Address Location
                              AccountAppIconTextWidget(
                                bigText: BigText(text: "Messages"),
                                appIcon: AppIcon(
                                  icon: Icons.message,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.iconSize24,
                                  backgroundColor: AppColors.greenColor,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //Logout Button
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedPreferences();
                                    Get.find<CartController>().clearList();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.offNamed(RouterHelper.getSignInPage());
                                  } else {
                                    // showCustomSnackbar('Please login');
                                  }
                                },
                                child: AccountAppIconTextWidget(
                                  bigText: BigText(text: "Logout"),
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.iconSize24,
                                    backgroundColor: AppColors.redColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : CustomCircularLoader())
            : Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 8,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/image/signintocontinue.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouterHelper.getSignInPage());
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 5,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: Center(
                            child: BigText(
                          text: 'Sign In',
                          color: Colors.white,
                          size: Dimensions.font20,
                        )),
                      ),
                    ),
                  ],
                )),
              );
      }),
    );
  }
}
