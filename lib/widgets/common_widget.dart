import 'package:commerce_project/const/app_const.dart';
import 'package:commerce_project/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

hideFocusKeyBoard(c) {
  FocusScope.of(c).requestFocus(FocusNode());
}

commonAppBar(
    {required BuildContext context,
      required String titleLabel,
      Function(bool)? onThemeToggle,
      bool isThemeToggle = true,
      void Function()? onTap,
      PreferredSizeWidget? bottom,
      List<Widget>? actions}) =>
    AppBar(
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.deepPurple,
      title: textWidget(
        text: titleLabel.tr,
        fontSize: 22,
        color: HexColor(CommonColors.whiteColor),
        fontFamily: AppDetails.aileronBold,
        fontWeight: FontWeight.w600,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      bottom: bottom,
      actions: actions,
    );

class textWidget extends StatelessWidget {
  String text;
  FontWeight? fontWeight;
  double? fontSize;
  Color? color;
  String? fontFamily;
  int? maxLines;
  TextOverflow? overflow;
  FontStyle? fontStyle;
  TextAlign? textAlign;
  TextDecoration? decoration;

  textWidget({super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize,
    this.maxLines,
    this.color,
    this.fontFamily,
    this.overflow,
    this.fontStyle,
    this.textAlign,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      style: TextStyle(
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: decoration,
        color: color,
        fontFamily: fontFamily,
        overflow: overflow,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

// Common Button
class CommonButton extends StatelessWidget {
  void Function()? onPressed;
  String buttonText;
  double fontSize;
  double height;
  double width;
  String buttonColor;
  String fontColor;
  String buttonFontFamily;
  FontWeight? fontWeight;
  BorderSide? borderSide;
  double borderRadius;

  CommonButton({super.key,
    required this.onPressed,
    required this.buttonText,
    this.height = 55.0,
    this.fontSize = 14.0,
    this.width = 254,
    this.buttonColor = "#212121",
    this.buttonFontFamily = "Aileron-Bold",
    this.fontWeight,
    this.borderRadius = 10.0,
    this.fontColor = "#FFFFFF",
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: HexColor(buttonColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: (borderSide != null)
                ? borderSide!
                : BorderSide(color: HexColor(buttonColor), width: 0),
          ),
        ),
        onPressed: onPressed,
        child: textWidget(
          text: buttonText.tr,
          color: HexColor(fontColor),
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: buttonFontFamily,
        ),
      ),
    );
  }
}

Future<bool?> deleteConfirmationDialogue(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Confirm Delete",
          style: TextStyle(
            fontFamily: AppDetails.aileronSemiBold,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        content: const Text(
          "Are you sure you want to delete this task?",
          style: TextStyle(
            fontFamily: AppDetails.aileronRegular,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(false), // No, do not delete
            child: const Text(
              "No",
              style: TextStyle( fontFamily: AppDetails.aileronRegular,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Yes, delete
            child: const Text(
              "Yes",
              style: TextStyle( fontFamily: AppDetails.aileronRegular,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}


// Custom SizedBox widget with adjustable height
class commonSizeBox extends StatelessWidget {
  final double height;
  final double width;

  const commonSizeBox({Key? key, this.height = 20.0,this.width= 20.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,width: width,);
  }
}


labelWithTextWidget({required String labelValue, required String labelKey,}) =>
    Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$labelKey :- ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: HexColor(CommonColors.blackColor),
                fontSize: 18,
                fontFamily: AppDetails.aileronSemiBold,
              ),
            ),
            TextSpan(
              text: labelValue.toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: HexColor(CommonColors.blackColor),
                fontSize: 16,
                fontFamily: AppDetails.aileronRegular,
              ),
            ),
          ],
        ),
      ),
    );

Widget buildShimmerList() {
  return ListView.builder(
    itemCount: 10, // Number of shimmer placeholders
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          leading: Container(
            width: 60.0,
            height: 60.0,
            color: Colors.white,
          ),
          title: Container(
            height: 20,
            color: Colors.white,
          ),
          subtitle: Container(
            height: 10,
            color: Colors.white,
          ),
        ),
      );
    },
  );
}

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputAction? textInputAction;
  final String? Function(String? msg)? validator;
  final TextInputType? keyboardType;
  final int maxLength;
  final bool obscureText;
  final bool isReadyOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  void Function()? onTaps;
  bool isDropDown = false;
  void Function(String)? onChanged;

  CommonTextFormField({
    required this.textInputAction,
    required this.validator,
    this.maxLength = 1024,
    required this.controller,
    this.isDropDown = false,
    required this.hintText,
    this.onTaps,
    this.suffixIcon,
    this.prefixIcon,
    this.isReadyOnly = false,
    this.obscureText = false,
    this.onChanged,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTaps,
      readOnly: isReadyOnly,
      onChanged: onChanged,
      obscureText: obscureText,
      maxLength: maxLength,
      textInputAction: textInputAction,
      validator: validator,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('[]')),
      ],
      controller: controller,
      style: TextStyle(
        fontFamily: AppDetails.aileronRegular,
        color: HexColor(CommonColors.blackColor),
      ),
      cursorColor: HexColor(CommonColors.blackColor),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterText: "",
        hintText: hintText!.tr,
        hintStyle: TextStyle(
          color: HexColor(CommonColors.hintColor),
          fontFamily: AppDetails.aileronRegular,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: HexColor(CommonColors.textFillColor),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: HexColor(CommonColors.blackColor),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: HexColor(CommonColors.textFillColor),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: HexColor(CommonColors.textFillColor),
          ),
        ),
      ),
    );
  }
}