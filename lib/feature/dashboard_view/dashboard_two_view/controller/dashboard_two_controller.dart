import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/models/dashboard_two_model.dart';

class SecondPageController extends GetxController {
  final selectedTab = 0.obs;
  final selectedSource = 'Source'.obs;

  final totalPower = 5.53.obs;
  final powerPercentage = 0.75.obs; // 75% of circle filled

  final energyDataList = <EnergyData>[
    EnergyData(
      title: 'Data View',
      data1: '55505.63',
      data2: '58805.63',
      isActive: true,
      icon: Icons.solar_power,
      color: Colors.blue,
    ),
    EnergyData(
      title: 'Data Type 2',
      data1: '55505.63',
      data2: '58805.63',
      isActive: true,
      icon: Icons.dashboard,
      color: Colors.orange,
    ),
    EnergyData(
      title: 'Data Type 3',
      data1: '55505.63',
      data2: '58805.63',
      isActive: false,
      icon: Icons.wind_power,
      color: Colors.blue,
    ),
  ].obs;

  final actionItems = <ActionItem>[
    ActionItem(
      title: 'Analysis Pro',
      icon: Icons.analytics,
      color: Colors.blue,
    ),
    ActionItem(
      title: 'G. Generator',
      icon: Icons.generating_tokens,
      color: Colors.orange,
    ),
    ActionItem(
      title: 'Plant Summary',
      icon: Icons.factory,
      color: Colors.orange,
    ),
    ActionItem(
      title: 'Natural Gas',
      icon: Icons.local_fire_department,
      color: Colors.red,
    ),
    ActionItem(
      title: 'D. Generator',
      icon: Icons.battery_charging_full,
      color: Colors.orange,
    ),
    ActionItem(
      title: 'Water Process',
      icon: Icons.water_drop,
      color: Colors.blue,
    ),
  ].obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void toggleSource(String source) {
    selectedSource.value = source;
  }
}
