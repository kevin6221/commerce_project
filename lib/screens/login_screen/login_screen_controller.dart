import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:commerce_project/api/database_helper.dart';
import 'package:commerce_project/screens/product_listing/product_list.dart';

class LoginScreenController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isPasswordObscured = true.obs;

  static String? loggedInUser;
   String loggedInUserName = "";

  @override
  void onInit() {
    super.onInit();
    checkLoggedIn();
  }

   checkLoggedIn() async {
    Map<String, dynamic>? userData = await DatabaseHelper.instance.getLoggedInUser();
    if (userData != null) {
      loggedInUser = userData['username'] as String?;

    } else {
      loggedInUser = null;
      loggedInUserName = "";
    }
    update(); // Notify GetX to update the UI, if necessary
  }

  void login(BuildContext context) async {
    String username = emailController.text.trim();
    String password = passwordController.text.trim();

    Map<String, dynamic>? user =
    await DatabaseHelper.instance.queryUser(username, password);

    if (user != null) {
      await DatabaseHelper.instance.saveLoggedInUser(username,password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          duration: Duration(seconds: 2),
        ),
      );
      Get.offAll(() => ProductScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
    update(); // Call update to notify the widget to rebuild
  }
}
