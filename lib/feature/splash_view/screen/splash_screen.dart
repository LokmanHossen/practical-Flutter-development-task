import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/app_sizer.dart';
import 'package:scube_app/core/constants/logo_path.dart';
import 'package:scube_app/core/style/global_text_style.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Image.asset(LogoPath.logo, height: 100, width: 98),
              SizedBox(height: 20.h),
              Text(
                'SCUBE ',
                style: globalTextStyle(
                  color: AppColors.secondary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0.h),
              Text(
                'Control & Monitoring System ',
                style: globalTextStyle(
                  color: AppColors.secondary,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
