import 'package:commerce_project/api/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordObscured = true.obs;

  void register(BuildContext context) async {
    String username = emailController.text.trim();
    String password = passwordController.text.trim();

    Map<String, dynamic> row = {
      DatabaseHelper.columnEmail: username,
      DatabaseHelper.columnPassword: password,
    };

    int id = await DatabaseHelper.instance.insert(row);
    print('Registered user id: $id');
    print('Registered user row: $row');

    // Navigate back to login screen after registration
    Navigator.pop(context);
  }



  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
    update(); // Call update to notify the widget to rebuild
  }

}