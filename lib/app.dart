// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:ryangalli_app/routes/app_routes.dart';
// import 'core/utils/constants/app_sizer.dart';
// import 'core/utils/constants/app_sizes.dart';
// import 'package:get/get.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AppSizes().init(context);
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           initialRoute: AppRoute.init,
//           getPages: AppRoute.routes,
//           themeMode: ThemeMode.system,
//           theme: ThemeData(scaffoldBackgroundColor: Colors.white),
//           locale: Get.deviceLocale,
//           builder: EasyLoading.init(),
//         );
//       },
//     );
//   }
// }
