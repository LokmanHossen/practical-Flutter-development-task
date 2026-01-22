 

  import 'package:flutter/material.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/icon_path.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/model/dashboard_one_model.dart';

Widget buildSystemInfo(SolarData data) {
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
