import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:scube_app/core/constants/app_sizer.dart';
import 'package:scube_app/routes/app_routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Scube App',
          getPages: AppRoute.routes,
          initialRoute: AppRoute.splashScreen,
          theme: ThemeData(scaffoldBackgroundColor: Colors.black),
        );
      },
    );
  }
}
