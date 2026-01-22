import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/icon_path.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/controller/temperature_card_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/controller/dashboard_one_controller.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/model/dashboard_one_model.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/widgets/temperature_card.dart';
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
                _buildTopMetrics(controller.solarData.value),
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
                _buildYesterdayDataContainer(controller.solarData.value),
                const SizedBox(height: 16),
                _buildSystemInfo(controller.solarData.value),
                const SizedBox(height: 16),
                ...controller.solarData.value.inverters.map(
                  (inv) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildInverterCard(inv),
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

  Widget _buildTopMetrics(SolarData data) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricCard(
                imagePath: IconPath.acIcon,

                iconBgColor: const Color(0xFFE9FAE9),
                title: '${data.liveAcPower.toInt()} kW',
                subtitle: 'Live AC Power',
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: MetricCard(
                imagePath: IconPath.gererationIcon,

                iconBgColor: const Color(0xFFE7F8F9),
                title: '${data.plantGeneration} %',
                subtitle: 'Plant Generation',
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: MetricCard(
                imagePath: IconPath.liveIcon,

                iconBgColor: const Color(0xFFF2F2FB),
                title: '${data.livePr} %',
                subtitle: 'Live PR',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                imagePath: IconPath.calculativeIcon,

                iconBgColor: const Color(0xFFE4F2FF),
                title: '${data.cumulativePr} %',
                subtitle: 'Cumulative PR',
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: MetricCard(
                imagePath: IconPath.returnIcon,

                iconBgColor: const Color(0xFFFDF6EA),
                title: '${data.returnPv.toInt()} ৳',
                subtitle: 'Return PV',
                subSmalltitle: '(Till Today)',

                smallSubtitle: true,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: MetricCard(
                imagePath: IconPath.energyIcon,

                iconBgColor: const Color(0xFFF7E8FD),
                title: '${data.totalEnergy.toInt()} kWh',
                subtitle: 'Total Energy',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYesterdayDataContainer(SolarData data) {
    final List<Map<String, String>> comparisonData = [
      {
        'label': 'AC Max Power',
        'yesterday': '${data.yesterdayAcMaxPower} kW',
        'today': '${data.todayAcMaxPower} kW',
      },
      {
        'label': 'Net Energy',
        'yesterday': '${data.yesterdayNetEnergy} kWh',
        'today': '${data.todayNetEnergy} kWh',
      },
      {
        'label': 'Specific Yield',
        'yesterday': '${data.yesterdaySpecificYield} kWh/kWp',
        'today': '${data.todaySpecificYield} kWh/kWp',
      },
      {
        'label': 'Net Energy',
        'yesterday': '${data.yesterdayNetEnergy} kWh',
        'today': '${data.todayNetEnergy} kWh',
      },
      {
        'label': 'Specific Yield',
        'yesterday': '${data.yesterdaySpecificYield} kWh/kWp',
        'today': '${data.todaySpecificYield} kWh/kWp',
      },
    ];

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  child: Text(
                    "Yesterday's Data",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Today's Data",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Color(0xFF9AA9BC)),
          Column(
            children: List.generate(
              comparisonData.length,
              (index) => Container(
                color: index.isEven ? Color(0xFFEEF3F9) : Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: _buildComparisonRow(
                  comparisonData[index]['label']!,
                  comparisonData[index]['yesterday']!,
                  comparisonData[index]['today']!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, String yesterday, String today) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.textPrimaryColor,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            yesterday,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          today,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSystemInfo(SolarData data) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4F2FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.asset(IconPath.solarIcon, width: 20, height: 20),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      const TextSpan(text: 'Total Num of PV Module   :   '),
                      TextSpan(
                        text:
                            '${data.totalPvModules} pcs. (${data.pcsPerModule} Wp each)',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: InfoCard(
                imagePath: IconPath.acIcon2,

                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Total AC Capacity',
                value: '${data.totalAcCapacity.toInt()} KW',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoCard(
                imagePath: IconPath.dcIcon,

                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Total DC Capacity',
                value: '${data.totalDcCapacity} MWp',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: InfoCard(
                imagePath: IconPath.dateIcon,

                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Date of Commissioning',
                value: data.commissioningDate,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoCard(
                imagePath: IconPath.numberIcon,

                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Number of Inverter',
                value: '${data.inverterCount}',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: InfoCard(
                imagePath: IconPath.acIcon2,

                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Total AC Capacity',
                value: '${data.totalAcCapacity.toInt()} KW',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoCard(
                imagePath: IconPath.dcIcon,

                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Total DC Capacity',
                value: '${data.totalDcCapacity} MWp',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInverterCard(InverterData inverter) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inverter.id,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              Row(
                children: [
                  Image.asset(IconPath.ltIcon, width: 16, height: 16),
                  const SizedBox(width: 8),
                  Text(
                    '${inverter.power} kWp / ${inverter.voltage.toInt()} kW',
                    style: TextStyle(
                      color: Color(0xFF0684D9),
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 20, color: Color(0xFFAFCCDF)),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    InverterMetric(
                      icon: IconPath.lifetimeIocn,
                      iconColor: const Color(0xFF2196F3),
                      iconBgColor: const Color(0xFFE3F2FD),
                      label: 'Lifetime Energy',
                      value: '${inverter.lifetimeEnergy} MWh',
                    ),
                    const SizedBox(height: 16),
                    InverterMetric(
                      icon: IconPath.metterIcon,
                      iconColor: const Color(0xFFFF9800),
                      iconBgColor: const Color(0xFFFFF3E0),
                      label: 'Prev. Meter Energy',
                      value: '${inverter.prevMeterEnergy} MWh',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    InverterMetric(
                      icon: IconPath.todayEnergyIcon,
                      iconColor: const Color(0xFFFFB300),
                      iconBgColor: const Color(0xFFFFF8E1),
                      label: 'Today Energy',
                      value: '${inverter.todayEnergy} kWh',
                    ),
                    const SizedBox(height: 16),
                    InverterMetric(
                      icon: IconPath.powerIcon,
                      iconColor: const Color(0xFF9C27B0),
                      iconBgColor: const Color(0xFFF3E5F5),
                      label: 'Live Power',
                      value: '${inverter.livePower} MWh',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String imagePath;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String? subSmalltitle;

  final bool smallSubtitle;

  const MetricCard({
    super.key,
    required this.imagePath,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    this.subSmalltitle,

    this.smallSubtitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(imagePath, width: 12, height: 12),
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  text: subtitle,
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF5E5E5E),
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: subSmalltitle,
                      style: TextStyle(
                        fontSize: 6,
                        color: Color(0xFF5E5E5E),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String imagePath;

  final Color iconBgColor;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.imagePath,

    required this.iconBgColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(imagePath, width: 16, height: 16),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textPrimaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InverterMetric extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final String value;

  const InverterMetric({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Image.asset(icon, width: 16, height: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
