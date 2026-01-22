import 'package:flutter/material.dart';

class EnergyData {
  final String title;
  final String data1;
  final String data2;
  final bool isActive;
  final IconData icon;
  final Color color;

  EnergyData({
    required this.title,
    required this.data1,
    required this.data2,
    required this.isActive,
    required this.icon,
    required this.color,
  });
}

class ActionItem {
  final String title;
  final IconData icon;
  final Color color;

  ActionItem({required this.title, required this.icon, required this.color});
}
