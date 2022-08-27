import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/utils/dimensions.dart';
import '../utils/colors.dart';

class AppTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icons;
  final bool obscureTexts;
  const AppTextfield(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.icons,
      this.obscureTexts = false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      child: TextField(
        obscureText: obscureTexts,
        controller: textEditingController,
        decoration: InputDecoration(
          //hintText , prefixIcon, focusedBorder , enabledBorder, borderSide.
          hintText: hintText,
          
          prefixIcon: (Icon(
            icons,
            color: AppColors.yellowColor,
          )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
              width: 1.0,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 3,
              offset: Offset(1, 1),
              color: Colors.grey.withOpacity(0.2),
            ),
          ],
          borderRadius: BorderRadius.circular(Dimensions.radius15)),
    );
  }
}
