import 'package:commerce_project/const/app_const.dart';
import 'package:commerce_project/const/assets_const.dart';
import 'package:commerce_project/const/color_const.dart';
import 'package:commerce_project/screens/login_screen/login_screen_controller.dart';
import 'package:commerce_project/screens/registration/registration.dart';
import 'package:commerce_project/utils/validation_utils.dart';
import 'package:commerce_project/widgets/common_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  final LoginScreenController loginScreenController =
      Get.put(LoginScreenController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        textWidget(
                          text: 'Login Screen',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: HexColor(CommonColors.blackColor),
                        ),
                        const SizedBox(height: 24),
                        CommonTextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              checkEmailAddressValidation(value: value!),
                          controller: loginScreenController.emailController,
                          hintText: "Enter Email",
                          keyboardType: TextInputType.text,
                        ),
                        commonSizeBox(height: 12),
                      Obx(() => CommonTextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: loginScreenController.passwordController,
                        hintText: "Enter Password",
                        obscureText: loginScreenController.isPasswordObscured.value,
                        suffixIcon: IconButton(
                          icon: Icon(loginScreenController.isPasswordObscured.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            loginScreenController.togglePasswordVisibility();
                          },
                        ),
                        validator: (value) => checkPasswordValidation(value: value!),
                      )),
                        commonSizeBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {},
                            child: textWidget(
                              text: 'Forgot Password?',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppDetails.aileronSemiBold,
                            ),
                          ),
                        ),
                        commonSizeBox(height: 16),
                        CommonButton(
                          onPressed: () {
                            // Validate the form
                            if (_formKey.currentState!.validate()) {
                              loginScreenController.login(context);
                            }
                          },
                          buttonText: 'Login',
                        ),
                        commonSizeBox(height: 16),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Create now',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(RegistrationScreen());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
