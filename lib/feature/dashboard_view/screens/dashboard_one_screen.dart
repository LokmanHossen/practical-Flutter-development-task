import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scube_app/core/constants/app_sizer.dart';
import 'package:scube_app/feature/dashboard_view/controller/dashboard_controller.dart';

class TemperatureScreen extends StatelessWidget {
  TemperatureScreen({super.key});
  final TemperatureController controller = Get.put(TemperatureController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Solar Plant Monitoring'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => TemperatureCard(
                temperature: controller.temperature.value,
                windSpeed: controller.windSpeed.value,
                windDirection: controller.windDirection.value,
                irradiation: controller.irradiation.value,
                weatherIcon: controller.weatherIcon.value,
                temperatureColor: controller.temperatureColor.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TemperatureCard extends StatelessWidget {
  final int temperature;
  final int windSpeed;
  final String windDirection;
  final double irradiation;
  final IconData weatherIcon;
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
          colors: [Colors.blue[400]!, Colors.purple[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$temperature°',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: temperatureColor,
                          ),
                        ),
                        Text(
                          'C',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: temperatureColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Text(
                      'Module',
                      style: TextStyle(fontSize: 16, color: Color(0xFF5E5E5E)),
                    ),
                    Text(
                      'Temperature',
                      style: TextStyle(fontSize: 14, color: Color(0xFF5E5E5E)),
                    ),
                  ],
                ),
                SizedBox(width: 12),
                SizedBox(
                  width: 50,
                  height: 130,
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
         
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$windSpeed MPH / $windDirection',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Wind Speed & Direction',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                      Icon(weatherIcon, color: Colors.yellow[300], size: 50),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${irradiation.toStringAsFixed(2)} w/m²',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Effective Irradiation',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

    final thermometerLeft = 30.0;
    final thermometerCenterX = thermometerLeft + 10;

    // Draw thermometer tube
    final tubeRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(thermometerLeft, 10, 20, size.height - 34),
      Radius.circular(10),
    );
    canvas.drawRRect(tubeRect, paint);

    // Draw bulb
    canvas.drawCircle(Offset(thermometerCenterX, size.height - 15), 16, paint);

    // Fill thermometer based on temperature with dynamic color
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = temperatureColor;

    // Calculate fill height
    final maxTemp = 45.0;
    final minTemp = 0.0;
    final tempRange = maxTemp - minTemp;
    final normalizedTemp = (temperature - minTemp).clamp(0, tempRange);
    final fillHeight = (normalizedTemp / tempRange) * (size.height - 60);

    final fillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        thermometerLeft + 3,
        size.height - 40 - fillHeight,
        14,
        fillHeight + 15,
      ),
      Radius.circular(8),
    );
    canvas.drawRRect(fillRect, fillPaint);

    // Fill bulb
    canvas.drawCircle(
      Offset(thermometerCenterX, size.height - 15),
      13,
      fillPaint,
    );

    // Draw scale marks
    final markPaint = Paint()
      ..color = Colors.grey[600]!
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final labels = ['45°C', '30°C', '15°C', '0°C'];
    final labelPositions = [0.0, 1 / 3, 2 / 3, 1.0];

    for (int i = 0; i < labels.length; i++) {
      final y = 35 + (labelPositions[i] * (size.height - 80));

      canvas.drawLine(
        Offset(thermometerLeft - 5, y),
        Offset(thermometerLeft, y),
        markPaint,
      );

      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(
          color: Colors.grey[700]!,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          thermometerLeft - 12 - textPainter.width,
          y - textPainter.height / 2,
        ),
      );

      canvas.drawLine(
        Offset(thermometerLeft, y),
        Offset(thermometerLeft + 20, y),
        Paint()
          ..color = Colors.grey[300]!.withOpacity(0.3)
          ..strokeWidth = 0.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
