// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TemperatureController extends GetxController {
//   var currentTemp = 17.0.obs;
//   var currentColor = Colors.blue.obs;
//   var currentIcon = Icons.cloud.obs;
//   var currentTime = '11:00 AM - 12:00 PM'.obs;

//   void setTimeSlot(int slot) {
//     switch (slot) {
//       case 1: // 11:00 AM to 12:00 PM
//         currentTemp.value = 17;
//         currentColor.value = Colors.blue;
//         currentIcon.value = Icons.cloud;
//         currentTime.value = '11:00 AM - 12:00 PM';
//         break;
//       case 2: // 12:00 PM to 01:00 PM
//         currentTemp.value = 30;
//         currentColor.value = Colors.red;
//         currentIcon.value = Icons.wb_sunny;
//         currentTime.value = '12:00 PM - 01:00 PM';
//         break;
//       case 3: // 02:30 PM to 03:30 PM
//         currentTemp.value = 19;
//         currentColor.value = Colors.green;
//         currentIcon.value = Icons.nightlight_round;
//         currentTime.value = '02:30 PM - 03:30 PM';
//         break;
//     }
//   }

//   double get thermoValue {
//     // Convert temperature to 0-1 range (assuming 0°C to 45°C range)
//     return (currentTemp.value / 45).clamp(0.0, 1.0);
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemperatureController extends GetxController {
  var temperature = 17.obs;
  var windSpeed = 26.obs;
  var windDirection = 'NW'.obs;
  var irradiation = 15.20.obs;
  var weatherIcon = Icons.wb_sunny.obs;

  void updateWeather(int temp, IconData icon) {
    temperature.value = temp;
    weatherIcon.value = icon;
  }
}
