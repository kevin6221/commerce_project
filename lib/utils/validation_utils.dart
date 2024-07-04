// Email Address Validation
import 'package:email_validator/email_validator.dart';

checkNameValidation({required String value}) {
  if (value.toString().isEmpty) {
    return "Please Enter Name";
  } else {
    return null;
  }
}

checkEmailAddressValidation({required String value}) {
  final bool isValid = EmailValidator.validate(value.toString().trim());
  if (value.toString().isEmpty) {
    return "Please Enter Your Email Address";
  } else if (isValid == false) {
    return 'Please Enter Valid Email Address';
  } else {
    return null;
  }
}

checkPasswordValidation({required String value}) {
  if (value.toString().isEmpty) {
    return "Please Enter Password";
  } else {
    return null;
  }
}