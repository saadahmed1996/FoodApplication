import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/dimensions.dart';

class CustomCircularLoader extends StatelessWidget {
  const CustomCircularLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height30 * 2,
      width: Dimensions.width10 * 2,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
      ),
      child: CircularProgressIndicator(
        semanticsLabel: "Please have Patience!",
        color: AppColors.mainColor,
        strokeWidth: 4,
      ),
    );
  }
}
