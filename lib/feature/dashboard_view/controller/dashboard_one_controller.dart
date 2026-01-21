
import 'package:get/get.dart';
import 'package:scube_app/feature/dashboard_view/model/dashboard_one_model.dart';


class DashboardOneController extends GetxController {
  final Rx<SolarData> solarData = SolarData.initial().obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    solarData.value = SolarData(
      liveAcPower: 10000,
      plantGeneration: 82.58,
      livePr: 85.61,
      cumulativePr: 27.58,
      returnPv: 10000,
      totalEnergy: 10000,
      yesterdayAcMaxPower: 1636.50,
      todayAcMaxPower: 2121.88,
      yesterdayNetEnergy: 6439.16,
      todayNetEnergy: 4875.77,
      yesterdaySpecificYield: 1.25,
      todaySpecificYield: 0.94,
      totalPvModules: 6372,
      pcsPerModule: 585,
      totalAcCapacity: 3000,
      totalDcCapacity: 3.727,
      commissioningDate: '17/07/2024',
      inverterCount: 30,
      inverters: [
        InverterData(
          id: 'LT_01',
          power: 495.505,
          voltage: 440,
          lifetimeEnergy: 352.96,
          prevMeterEnergy: 0.00,
          todayEnergy: 273.69,
          livePower: 352.96,
        ),
        InverterData(
          id: 'LT_01',
          power: 495.505,
          voltage: 440,
          lifetimeEnergy: 352.96,
          prevMeterEnergy: 0.00,
          todayEnergy: 273.69,
          livePower: 352.96,
        ),
      ],
    );
  }

  void navigateToSecondPage() {
    Get.snackbar('Navigation', '2nd Page Navigate clicked');
  }
}