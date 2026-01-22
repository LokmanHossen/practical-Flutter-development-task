import 'package:flutter/material.dart';
import 'package:scube_app/core/constants/app_colors.dart';
import 'package:scube_app/core/constants/app_sizer.dart';
import 'package:scube_app/core/style/global_text_style.dart';

class TemperatureCard extends StatelessWidget {
  final int temperature;
  final int windSpeed;
  final String windDirection;
  final double irradiation;
  final Image weatherIcon;
  final Color temperatureColor;

  const TemperatureCard({
    super.key,
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.irradiation,
    required this.weatherIcon,
    required this.temperatureColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Color(0xFF2E63F7), Color(0xFFB982D9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$temperature°',
                          style: globalTextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: temperatureColor,
                          ),
                        ),
                        Text(
                          'C',
                          style: globalTextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: temperatureColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    Text(
                      'Module',
                      style: globalTextStyle(
                        fontSize: 10,
                        color: AppColors.textPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Temperature',
                      style: globalTextStyle(
                        fontSize: 10,
                        color: AppColors.textPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: 45,
                  height: 105,
                  child: CustomPaint(
                    painter: ThermometerPainter(
                      temperature: temperature,
                      temperatureColor: temperatureColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  '$windSpeed MPH / $windDirection',
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Wind Speed & Direction',
                  style: globalTextStyle(
                    fontSize: 10.sp,
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 95,
                  height: 1.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFC2CEFF), Color(0xFF728DF8)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  '${irradiation.toStringAsFixed(2)} w/m²',
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Effective Irradiation',
                  style: globalTextStyle(
                    fontSize: 10.sp,
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 50, height: 50, child: weatherIcon),
        ],
      ),
    );
  }
}

class ThermometerPainter extends CustomPainter {
  final int temperature;
  final Color temperatureColor;

  ThermometerPainter({
    required this.temperature,
    required this.temperatureColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.grey[800]!;

    final thermometerLeft = 25.0;
    final thermometerCenterX = thermometerLeft + 7;

    final tubeRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(thermometerLeft, 0, 14, size.height - 30),
      Radius.circular(7),
    );
    canvas.drawRRect(tubeRect, paint);

    canvas.drawCircle(Offset(thermometerCenterX, size.height - 15), 18, paint);

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = temperatureColor;

    final maxTemp = 45.0;
    final minTemp = 0.0;
    final tempRange = maxTemp - minTemp;
    final normalizedTemp = (temperature - minTemp).clamp(0, tempRange);
    final fillHeight = (normalizedTemp / tempRange) * (size.height - 60);

    final fillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        thermometerLeft + 2.5,
        size.height - 48 - fillHeight,
        9.2,
        fillHeight + 17,
      ),
      Radius.circular(5),
    );
    canvas.drawRRect(fillRect, fillPaint);

    canvas.drawCircle(
      Offset(thermometerCenterX, size.height - 15),
      14.5,
      fillPaint,
    );

    final markPaint = Paint()
      ..color = Colors.grey[600]!
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final labels = ['45°C', '30°C', '15°C', '0°C'];
    final labelPositions = [0.0, 1 / 3, 2 / 3, 1.0];

    for (int i = 0; i < labels.length; i++) {
      final y = 15 + (labelPositions[i] * (size.height - 55));

      canvas.drawLine(
        Offset(thermometerLeft - 7, y),
        Offset(thermometerLeft, y),
        markPaint,
      );

      textPainter.text = TextSpan(
        text: labels[i],
        style: globalTextStyle(
          color: AppColors.textPrimaryColor,
          fontSize: 8,
          fontWeight: FontWeight.w700,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          thermometerLeft - 8 - textPainter.width,
          y - textPainter.height / 2,
        ),
      );

      canvas.drawLine(
        Offset(thermometerLeft, y),
        Offset(thermometerLeft + 20, y),
        Paint()
          ..color = Colors.grey[300]!.withValues(alpha: 0.3)
          ..strokeWidth = 0.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
