  import 'package:flutter/material.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/model/dashboard_one_model.dart';

Widget buildYesterdayDataContainer(SolarData data) {
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
