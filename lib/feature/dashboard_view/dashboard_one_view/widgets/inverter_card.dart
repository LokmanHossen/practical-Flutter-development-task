import 'package:flutter/material.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/icon_path.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/model/dashboard_one_model.dart';

Widget buildInverterCard(InverterData inverter) {
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
