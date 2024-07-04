import 'dart:async';
import 'package:commerce_project/screens/login_screen/login_screen.dart';
import 'package:commerce_project/screens/login_screen/login_screen_controller.dart';
import 'package:commerce_project/screens/product_listing/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'const/app_const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      title: AppDetails.appName,
      home:  LoginScreenController.loggedInUser != null ? ProductScreen() : LoginScreen()
    );
  }
}
