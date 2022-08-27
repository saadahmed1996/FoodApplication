import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import 'package:flutter_application_1/weidgets/app_icon.dart';
import 'package:flutter_application_1/weidgets/big_text.dart';

class AccountAppIconTextWidget extends StatelessWidget {
  BigText bigText;
  AppIcon appIcon;
  AccountAppIconTextWidget(
      {Key? key, required this.bigText, required this.appIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Dimensions.height30 * 2,
      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width20,
          ),
          bigText,
        ],
      ),
    );
  }
}
