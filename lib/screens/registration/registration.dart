import 'package:commerce_project/const/assets_const.dart';
import 'package:commerce_project/screens/registration/registration_controller.dart';
import 'package:commerce_project/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:commerce_project/const/color_const.dart';
import 'package:commerce_project/widgets/common_widget.dart';
import 'package:commerce_project/screens/login_screen/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final RegistrationController registrationController =
  Get.put(RegistrationController());

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
                        Text(
                          'User Registration',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: HexColor(CommonColors.blackColor),
                          ),
                        ),
                        const SizedBox(height: 24),
                        buildNameTextField(),
                        const SizedBox(height: 12),
                        buildEmailTextField(),
                        const SizedBox(height: 12),
                        _buildPasswordTextField(),
                        const SizedBox(height: 24),
                        _buildRegisterButton(context),
                        const SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Login now',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(LoginScreen());
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

  Widget buildNameTextField() {
    return CommonTextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      controller: registrationController.nameController,
      hintText: "Enter Name",
      validator: (value) => checkNameValidation(value: value!),
    );
  }

  Widget buildEmailTextField() {
    return CommonTextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: registrationController.emailController,
      hintText: "Enter Email",
      validator: (value) => checkEmailAddressValidation(value: value!),
    );
  }

  Widget _buildPasswordTextField() {
    return Obx(() => CommonTextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: registrationController.passwordController,
      hintText: "Enter Password",
      obscureText: registrationController.isPasswordObscured.value,
      suffixIcon: IconButton(
        icon: Icon(registrationController.isPasswordObscured.value
            ? Icons.visibility
            : Icons.visibility_off),
        onPressed: () {
          registrationController.togglePasswordVisibility();
        },
      ),
      validator: (value) => checkPasswordValidation(value: value!),
    ));
  }

  Widget _buildRegisterButton(BuildContext context) {
    return CommonButton(
      onPressed: () {
        // Validate the form
        if (_formKey.currentState!.validate()) {
          // If valid, register the user
          registrationController.register(context);
        }
      },
      buttonText: 'Register',
    );
  }
}
