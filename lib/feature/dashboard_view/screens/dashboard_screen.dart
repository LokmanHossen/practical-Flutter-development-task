import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Simulate Time-Based Changes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TimeButton(
              time: '11:00 am - 12:00 pm',
              temperature: 17,
              icon: Icons.wb_cloudy,
              onPressed: () => controller.updateWeather(17, Icons.wb_cloudy),
            ),
            SizedBox(height: 12),
            TimeButton(
              time: '12:00 pm - 01:00 pm',
              temperature: 30,
              icon: Icons.wb_sunny,
              onPressed: () => controller.updateWeather(30, Icons.wb_sunny),
            ),
            SizedBox(height: 12),
            TimeButton(
              time: '02:30 pm - 03:30 pm',
              temperature: 19,
              icon: Icons.nightlight_round,
              onPressed: () =>
                  controller.updateWeather(19, Icons.nightlight_round),
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

  const TemperatureCard({
    Key? key,
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.irradiation,
    required this.weatherIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          // Left side - Temperature
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$temperature°C',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Module',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  Text(
                    'Temperature',
                    style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
          // Thermometer with labels
          Container(
            width: 100, // Increased width for labels
            height: 130,
            child: CustomPaint(
              painter: ThermometerPainter(temperature: temperature),
            ),
          ),
          // Right side - Weather info
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.purple[400]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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

  ThermometerPainter({required this.temperature});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.grey[800]!;

    // Calculate thermometer position (right side of labels)
    final thermometerLeft = 30.0; // Leave space for labels
    final thermometerCenterX =
        thermometerLeft + 10; // Center of thermometer tube

    // Draw thermometer tube
    final tubeRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(thermometerLeft, 10, 20, size.height - 34),
      Radius.circular(10),
    );
    canvas.drawRRect(tubeRect, paint);

    // Draw bulb
    canvas.drawCircle(Offset(thermometerCenterX, size.height - 15), 16, paint);

    // Fill thermometer based on temperature
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = temperature > 25 ? Colors.red : Colors.blue;

    // Calculate fill height (temperature ranges from 0-45°C)
    final maxTemp = 45.0;
    final minTemp = 0.0;
    final tempRange = maxTemp - minTemp;
    final normalizedTemp = (temperature - minTemp).clamp(0, tempRange);
    final fillHeight = (normalizedTemp / tempRange) * (size.height - 60);

    final fillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        thermometerLeft + 2,
        size.height - 30 - fillHeight,
        16,
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

    // Draw temperature labels on the left side
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final labels = ['45°C', '30°C', '15°C', '0°C'];
    final labelPositions = [
      0.0,
      1 / 3,
      2 / 3,
      1.0,
    ]; // Positions from top to bottom

    for (int i = 0; i < labels.length; i++) {
      final y = 35 + (labelPositions[i] * (size.height - 80));

      // Draw scale mark line
      canvas.drawLine(
        Offset(thermometerLeft - 5, y),
        Offset(thermometerLeft, y),
        markPaint,
      );

      // Draw label
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

      // Draw horizontal guide line across thermometer
      canvas.drawLine(
        Offset(thermometerLeft, y),
        Offset(thermometerLeft + 20, y),
        Paint()
          ..color = Colors.grey[300]!.withOpacity(0.3)
          ..strokeWidth = 0.5,
      );
    }

    textPainter.text = TextSpan(
      text: '${temperature}°C',
      style: TextStyle(
        color: Colors.blue[800]!,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TimeButton extends StatelessWidget {
  final String time;
  final int temperature;
  final IconData icon;
  final VoidCallback onPressed;

  const TimeButton({
    Key? key,
    required this.time,
    required this.temperature,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 30),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '$temperature°C',
                  style: TextStyle(fontSize: 14, color: Colors.blue[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
