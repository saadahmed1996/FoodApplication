import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/popular_product_controller.dart';
import 'package:flutter_application_1/controllers/recommended_controller.dart';
import 'package:flutter_application_1/routes/route_helper.dart';
import 'package:flutter_application_1/weidgets/custom_circular_loader.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/helper/dependencies.dart' as dep;
import 'controllers/cart_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Here we are injecting dependencies with this init function.
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Calling getCartData so the prevoius stored values will be printed even after the application has been restarted.
    Get.find<CartController>().getCartData();
    //It needs to be returned before the GetMaterialApp other wise PopularProductController will be dipose off or deleted.
    return GetBuilder<PopularProductController>(
      builder: (_) {
        //It needs to be returned before the GetMaterialApp other wise RecommendedProductController will be dipose off or deleted.
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            //after the intialization for product and recommended controller, We will return GetMaterialApp to get us to the
            //Splash screen with the help of routers.
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              initialRoute: RouterHelper.getSplashPage(),
              getPages: RouterHelper.routes,
              // home: SignInPage(),
              // home: CustomCircularLoader(),
            );
          },
        );
      },
    );
  }
}

//HOW TO ADD MORE FIELDS AND NEW TABLE IN FOOD CATEGORY:
//If the clients wants to add more field or new table.
//1) Create a link in App constant class
//2) Make a method in Database app/http/Controllers/Api/v1/ ProductController.php 
//3) Then assign a method in api/v1/ api.php
//4) Simply call a link URL from App Contant in Repository.
//5) Use RefreshIndicator Widget to update the application just by swip down.

//IT WILL ALWAYS SHOW THE LAST ADDED IN FRONT OF OUR APP:
//Creating order by Desc orders.
//->orderBy('Created_at', 'DESC')


//Changes Made on
//25-AUG-2022
