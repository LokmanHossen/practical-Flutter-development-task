import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            // Image.asset(LogoPath.logo, height: 250, width: 250),
            Spacer(),
            // SpinKitFadingCircle(color: Colors.white),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
