import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/icon_path.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/controller/temperature_card_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/controller/dashboard_one_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/inverter_card.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/system_info.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/temperature_card.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/top_metrics.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/yesterday_data_container.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/screen/dashboard_two_screen.dart';

class DashboardOneScreen extends StatelessWidget {
  const DashboardOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardOneController controller = Get.put(DashboardOneController());
    final TemperatureController temperatureController = Get.put(
      TemperatureController(),
    );

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
        title: const Text(
          '1st Page',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          child: SafeArea(
            child: Column(
              children: [
                _buildNavigateButton(controller),
                const SizedBox(height: 16),
                buildTopMetrics(controller.solarData.value),
                const SizedBox(height: 16),
                Obx(
                  () => TemperatureCard(
                    temperature: temperatureController.temperature.value,
                    windSpeed: temperatureController.windSpeed.value,
                    windDirection: temperatureController.windDirection.value,
                    irradiation: temperatureController.irradiation.value,
                    weatherIcon: temperatureController.weatherIcon.value,
                    temperatureColor:
                        temperatureController.temperatureColor.value,
                  ),
                ),
                const SizedBox(height: 16),
                buildYesterdayDataContainer(controller.solarData.value),
                const SizedBox(height: 16),
                buildSystemInfo(controller.solarData.value),
                const SizedBox(height: 16),
                ...controller.solarData.value.inverters.map(
                  (inv) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: buildInverterCard(inv),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigateButton(DashboardOneController controller) {
    return InkWell(
      onTap: () => Get.to(() => DashboardTwoScreen()),

      child: Container(
        // height: 32,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFF00C0E8),

          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '2nd Page Navigate',
              style: TextStyle(
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