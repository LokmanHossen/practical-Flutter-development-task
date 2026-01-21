import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:scube_app/core/constants/icon_path.dart';

class TemperatureController extends GetxController {
  var temperature = 17.obs;
  var windSpeed = 26.obs;
  var windDirection = 'NW'.obs;
  var irradiation = 15.20.obs;
  var weatherIcon = Image.asset(IconPath.cloudIcon).obs;
  var temperatureColor = Colors.blue.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    updateWeatherBasedOnTime();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      updateWeatherBasedOnTime();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void updateWeatherBasedOnTime() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;

    // 11:00 AM - 12:00 PM (660 - 720 minutes)
    if (currentMinutes >= 660 && currentMinutes < 720) {
      temperature.value = 17;
      weatherIcon.value = Image.asset(IconPath.cloudIcon);
      temperatureColor.value = Colors.blue;
      windSpeed.value = 26;
      windDirection.value = 'NW';
      irradiation.value = 15.20;
    }
    // 12:00 PM - 01:00 PM (720 - 780 minutes)
    else if (currentMinutes >= 720 && currentMinutes < 780) {
      temperature.value = 30;
      weatherIcon.value = Image.asset(IconPath.sunnyIcon);
      temperatureColor.value = Colors.red;
      windSpeed.value = 18;
      windDirection.value = 'N';
      irradiation.value = 25.50;
    }
    // 02:30 PM - 03:30 PM (870 - 930 minutes)
    else if (currentMinutes >= 870 && currentMinutes < 930) {
      temperature.value = 19;
      weatherIcon.value = Image.asset(IconPath.moonIcon);
      temperatureColor.value = Colors.green;
      windSpeed.value = 22;
      windDirection.value = 'NE';
      irradiation.value = 18.30;
    }
    // Default for other times
    else {
      temperature.value = 20;
      weatherIcon.value = Image.asset(IconPath.sunnyIcon);
      temperatureColor.value = Colors.orange;
      windSpeed.value = 20;
      windDirection.value = 'N';
      irradiation.value = 20.00;
    }
  }
}