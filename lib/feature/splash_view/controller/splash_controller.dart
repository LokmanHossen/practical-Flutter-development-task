import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startDelay();
  }


    void startDelay() {
    Timer(Duration(seconds: 1), () {
      Get.offNamed(AppRoute.loginScreen);
    });
  }



}
