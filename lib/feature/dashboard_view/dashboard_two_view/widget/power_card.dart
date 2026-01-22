import 'package:flutter/material.dart';
import 'package:scube_app/core/constants/app_colors.dart';

class PowerChart extends StatelessWidget {
  const PowerChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 175,
            height: 175,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFF0096FC).withValues(alpha: 0.2),
                width: 25,
              ),
            ),
          ),

          SizedBox(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(
              value: 0.75,
              strokeWidth: 25,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF0096FC),
              ),
            ),
          ),
          // Center text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Power',
                style: TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '5.53 kw',
                style: TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
