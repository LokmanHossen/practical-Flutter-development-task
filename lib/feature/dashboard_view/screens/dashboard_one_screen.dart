import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/feature/dashboard_view/controller/temperature_card_controller.dart';
import 'package:scube_app/feature/dashboard_view/controller/dashboard_one_controller.dart';
import 'package:scube_app/feature/dashboard_view/model/dashboard_one_model.dart';
import 'package:scube_app/feature/dashboard_view/screens/temperature_card.dart';


class DashboardOneScreen extends StatelessWidget {
  const DashboardOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardOneController controller = Get.put(DashboardOneController());
    final TemperatureController temperatureController = Get.put(TemperatureController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          '1st Page',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
                temperatureColor: temperatureController.temperatureColor.value,
              ),
            ),
            const SizedBox(height: 16),
            _buildYesterdayDataContainer(controller.solarData.value),
            const SizedBox(height: 16),
            _buildSystemInfo(controller.solarData.value),
            const SizedBox(height: 16),
            ...controller.solarData.value.inverters
                .map((inv) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildInverterCard(inv),
                    ))
                ,
          ],
        ),
      )),
    );
  }

  Widget _buildNavigateButton(DashboardOneController controller) {
    return InkWell(
      onTap: controller.navigateToSecondPage,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF5CB8E6), Color(0xFF67C2EC)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '2nd Page Navigate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ),
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
                icon: Icons.flash_on_rounded,
                iconColor: const Color(0xFF4CAF50),
                iconBgColor: const Color(0xFFE8F5E9),
                title: '${data.liveAcPower.toInt()} kW',
                subtitle: 'Live AC Power',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                icon: Icons.factory_outlined,
                iconColor: const Color(0xFF2196F3),
                iconBgColor: const Color(0xFFE3F2FD),
                title: '${data.plantGeneration} %',
                subtitle: 'Plant Generation',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                icon: Icons.person_outline,
                iconColor: const Color(0xFF9C27B0),
                iconBgColor: const Color(0xFFF3E5F5),
                title: '${data.livePr} %',
                subtitle: 'Live PR',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                icon: Icons.show_chart,
                iconColor: const Color(0xFF2196F3),
                iconBgColor: const Color(0xFFE3F2FD),
                title: '${data.cumulativePr} %',
                subtitle: 'Cumulative PR',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                icon: Icons.currency_exchange,
                iconColor: const Color(0xFFFF9800),
                iconBgColor: const Color(0xFFFFF3E0),
                title: '${data.returnPv.toInt()} ৳',
                subtitle: 'Return PV(Till Today)',
                smallSubtitle: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                icon: Icons.energy_savings_leaf_outlined,
                iconColor: const Color(0xFF9C27B0),
                iconBgColor: const Color(0xFFF3E5F5),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Yesterday's Data",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Today's Data",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.textPrimaryColor
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          Column(
            children: List.generate(
              comparisonData.length,
              (index) => Container(
                color: index.isEven ? Color(0xFFEEF3F9) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
      children: [
        Expanded(
          flex: 5,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: AppColors.textPrimaryColor,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            yesterday,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            today,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSystemInfo(SolarData data) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.solar_power_outlined,
                  color: Color(0xFF2196F3),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      const TextSpan(text: 'Total Num of PV Module   :   '),
                      TextSpan(
                        text: '${data.totalPvModules} pcs. (${data.pcsPerModule} Wp each)',
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
                icon: Icons.electric_bolt_outlined,
                iconColor: const Color(0xFF2196F3),
                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Total AC Capacity',
                value: '${data.totalAcCapacity.toInt()} KW',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoCard(
                icon: Icons.cable_outlined,
                iconColor: const Color(0xFF2196F3),
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
                icon: Icons.calendar_today_outlined,
                iconColor: const Color(0xFF2196F3),
                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Date of Commissioning',
                value: data.commissioningDate,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoCard(
                icon: Icons.devices_outlined,
                iconColor: const Color(0xFF2196F3),
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
                icon: Icons.power_outlined,
                iconColor: const Color(0xFF2196F3),
                iconBgColor: const Color(0xFFE3F2FD),
                title: 'Total AC Capacity',
                value: '${data.totalAcCapacity.toInt()} KW',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoCard(
                icon: Icons.battery_charging_full_outlined,
                iconColor: const Color(0xFF2196F3),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inverter.id,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.bolt_rounded,
                      color: Color(0xFF2196F3),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${inverter.power} kWp / ${inverter.voltage.toInt()} kW',
                    style: const TextStyle(
                      color: Color(0xFF2196F3),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    InverterMetric(
                      icon: Icons.flash_on_rounded,
                      iconColor: const Color(0xFF2196F3),
                      iconBgColor: const Color(0xFFE3F2FD),
                      label: 'Lifetime Energy',
                      value: '${inverter.lifetimeEnergy} MWh',
                    ),
                    const SizedBox(height: 16),
                    InverterMetric(
                      icon: Icons.bolt_outlined,
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
                      icon: Icons.hourglass_bottom_rounded,
                      iconColor: const Color(0xFFFFB300),
                      iconBgColor: const Color(0xFFFFF8E1),
                      label: 'Today Energy',
                      value: '${inverter.todayEnergy} kWh',
                    ),
                    const SizedBox(height: 16),
                    InverterMetric(
                      icon: Icons.power_outlined,
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
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final bool smallSubtitle;

  const MetricCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    this.smallSubtitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: smallSubtitle ? 10.5 : 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
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
  final IconData icon;
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
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
