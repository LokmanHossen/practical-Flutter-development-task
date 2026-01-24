import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/controller/temperature_card_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/controller/dashboard_one_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/screens/dashboard_screen.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/inverter_card.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/system_info.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/temperature_card.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/top_metrics.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/yesterday_data_container.dart';

class DashboardOneScreen extends StatelessWidget {
  const DashboardOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardScreen();
  }
}

class DashboardOneContent extends StatelessWidget {
  const DashboardOneContent({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardOneController controller = Get.put(DashboardOneController());
    final TemperatureController temperatureController = Get.put(
      TemperatureController(),
    );

    return Obx(
      () => Column(
        children: [
          buildTopMetrics(controller.solarData.value),
          const SizedBox(height: 16),
          Obx(
            () => TemperatureCard(
              temperature: temperatureController.temperature.value,
              windSpeed: temperatureController.windSpeed.value,
              windDirection: temperatureController.windDirection.value,
              irradiation: temperatureController.irradiation.value,
              weatherIcon: temperatureController.weatherIcon.value,
              temperatureColor: temperatureController.temperatureColor.value,
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
    );
  }
}