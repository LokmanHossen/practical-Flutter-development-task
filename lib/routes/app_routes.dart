import 'package:get/get.dart';
import 'package:scube_app/splash/screen/splash_screen.dart';


class AppRoute {
  static String splashScreen = "/splashScreen";
  static String navbar = "/navbar";
  static String loginScreen = "/loginScreen";


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
   
  
   
  ];
}
