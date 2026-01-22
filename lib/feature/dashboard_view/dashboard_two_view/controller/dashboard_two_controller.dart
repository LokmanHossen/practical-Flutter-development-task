import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/core/constants/icon_path.dart';
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
      image: IconPath.solarTwoIcon,
      color: Color(0xFF78C6FF)
    ),
    EnergyData(
      title: 'Data Type 2',
      data1: '55505.63',
      data2: '58805.63',
      isActive: true,
       image: IconPath.typeTwoIcon,
      color: Color(0xFFFB902E),
    ),
    EnergyData(
      title: 'Data Type 3',
      data1: '55505.63',
      data2: '58805.63',
      isActive: false,
      image: IconPath.typeThreeIcon,
      color: Color(0xFF78C6FF)
    ),
  ].obs;

  final actionItems = <ActionItem>[
    ActionItem(
      title: 'Analysis Pro',
     image: IconPath.analysisIcon,
   
    ),
    ActionItem(
      title: 'G. Generator',
      image: IconPath.gGeneratorIcon,
  
    ),
    ActionItem(
      title: 'Plant Summary',
     image: IconPath.pluginIcon,

    ),
    ActionItem(
      title: 'Natural Gas',
      image: IconPath.gassIcon,
  
    ),
    ActionItem(
      title: 'D. Generator',
   image: IconPath.gGeneratorIcon,
    
    ),
    ActionItem(
      title: 'Water Process',
     image: IconPath.waterIcon,
      
    ),
  ].obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void toggleSource(String source) {
    selectedSource.value = source;
  }
}
