import 'package:flutter/material.dart';

class EnergyData {
  final String title;
  final String data1;
  final String data2;
  final bool isActive;
  final String image;
  final Color color;

  EnergyData({
    required this.title,
    required this.data1,
    required this.data2,
    required this.isActive,
    required this.image,
    required this.color,
  });
}

class ActionItem {
  final String title;
  final String image;


  ActionItem({required this.title, required this.image,});
}
