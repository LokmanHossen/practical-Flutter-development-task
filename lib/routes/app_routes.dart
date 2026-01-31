import 'package:get/get.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/screens/dashboard_one_screen.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_one_view/screens/dashboard_screen.dart';
import 'package:scube_app/feature/dashboard_view/dashboard_two_view/screen/dashboard_two_screen.dart';
import 'package:scube_app/feature/login_view/screen/login_screen.dart';
import 'package:scube_app/feature/splash_view/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String loginScreen = "/loginScreen";
  static String dashboardScreen = "/dashboardScreen";
  static String dashboardOneScreen = "/dashboardOneScreen";
  static String dashboardTwoScreen = "/dashboardTwoScreen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: dashboardScreen, page: () => DashboardScreen()),

    GetPage(name: dashboardOneScreen, page: () => DashboardOneScreen()),
    GetPage(name: dashboardTwoScreen, page: () => DashboardTwoScreen()),
  ];
}
