 import 'package:flutter/material.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/icon_path.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/model/dashboard_one_model.dart';

Widget buildTopMetrics(SolarData data) {
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
