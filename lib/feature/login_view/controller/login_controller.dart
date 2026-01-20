import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scube_app/feature/login_view/screen/login_screen.dart';
class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
  
    WidgetsBinding.instance.addPostFrameCallback((_) {
       showLoginBottomSheet();
    });
  }

  void showLoginBottomSheet() {
    showMaterialModalBottomSheet(
      context: Get.context!,
      builder: (context) => LoginBottomSheet(),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      duration: Duration(milliseconds: 2000),
      expand: false,
      bounce: true,
    );
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}




// class LoginController extends GetxController {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final isPasswordVisible = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//           showLoginBottomSheet();
//     });
//   }

//   void showLoginBottomSheet() {
//     Get.bottomSheet(
//       LoginBottomSheet(),
//       isScrollControlled: true,
//       isDismissible: true,
//       enableDrag: true,
//       backgroundColor: Colors.transparent,
//       enterBottomSheetDuration: Duration(milliseconds: 1600),
//       exitBottomSheetDuration: Duration(milliseconds: 400),
//     );
//   }

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   void login() {
//     debugPrint('Username: ${usernameController.text}');
//     debugPrint('Password: ${passwordController.text}');
//   }

//   void forgotPassword() {
//     debugPrint('Forgot password clicked');
//   }

//   void register() {
//     debugPrint('Register clicked');
//   }

//   @override
//   void onClose() {
//     usernameController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }