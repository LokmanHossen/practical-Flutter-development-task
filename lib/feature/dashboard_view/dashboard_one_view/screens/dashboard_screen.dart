import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/icon_path.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/screens/dashboard_one_screen.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/screen/dashboard_two_screen.dart';
import 'package:scube_app/routes/app_routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final isFirstPage = currentRoute == AppRoute.dashboardOneScreen;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isFirstPage ? '1st Page' : '2nd Page',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Badge(
              smallSize: 11,
              child: Image.asset(IconPath.notificationIcon, height: 24),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              _buildNavigateButton(isFirstPage),
              const SizedBox(height: 16),
              isFirstPage
                  ? const DashboardOneContent()
                  : const DashboardTwoContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigateButton(bool isFirstPage) {
    return InkWell(
      onTap: () {
        if (isFirstPage) {
          Get.toNamed(AppRoute.dashboardTwoScreen);
        } else {
          Get.toNamed(AppRoute.dashboardOneScreen);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF00C0E8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFirstPage ? '2nd Page Navigate' : '1st Page Navigate',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}