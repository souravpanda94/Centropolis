import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_toast.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_colors.dart';

showToastMessage(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: CustomColors.baseColor,
      textColor: CustomColors.whiteColor,
      fontSize: 14.0);
}

void showCustomToast(
    FToast fToast, BuildContext context, String message, String icon) {
  fToast = FToast();
  fToast.init(context);
  fToast.showToast(
      child: CustomToast(message, icon),
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 100.0,
          child: child,
        );
      });
}

onBackButtonPress(BuildContext context) {
  Navigator.pop(context);
  FocusManager.instance.primaryFocus?.unfocus();
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void cleanLoginData(BuildContext context) {
  var user = Provider.of<UserProvider>(context, listen: false);
  user.doRemoveUser();
}

void removeLoginCredential(BuildContext context) {
  var user = Provider.of<UserProvider>(context, listen: false);
  user.doRemoveUser();
  Navigator.of(context).popUntil((route) => route.isFirst);
  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => const LoginScreen(),
  //   ),
  // );
}

bool isValidEmail(String email) {
  bool emailValid = false;
  if (email != "") {
    emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
  return emailValid;
}

bool isValidUserId(String userId) {
  if (userId.isEmpty) {
    return false;
  }
  if (userId.contains(RegExp(r'[A-Z]'))) {
    return false;
  } else {
    bool hasDigits = userId.contains(RegExp(r'[0-9]'));
    bool hasLowercase = userId.contains(RegExp(r'[a-z]'));
    bool hasMinLength = userId.length >= 4;
    bool hasMaxLength = userId.length <= 16;

    return hasDigits & hasLowercase & hasMaxLength & hasMinLength;
  }
}

bool isValidPassword(String password, [int minLength = 8]) {
  if (password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_-]'));
  bool hasMinLength = password.length >= minLength;

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}

bool isInvalidNickName(String nickName) {
//bool hasDigits = RegExp(r'[0-9]').hasMatch(nickName);
// bool hasDigits = isNumeric(nickName);
  bool hasSpecialCharacters =
      nickName.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  return hasSpecialCharacters; // || hasDigits;
}

bool isNumeric(String s) {
// ignore: unnecessary_null_comparison
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

bool isValidPhoneNumber(String phoneNumber, [int length = 11]) {
  bool result = false;
  if (phoneNumber.isEmpty) {
    result = false;
  } else if (phoneNumber.length == length) {
    result = true;
  } else {
    result = false;
  }
  return result;
}

bool isValidOtp(String otp, [int length = 6]) {
  bool result = false;
  if (otp.isEmpty) {
    result = false;
  } else if (otp.length == length) {
    result = true;
  } else {
    result = false;
  }
  return result;
}

bool isInvalidHoneyCount(String password, [int minLength = 8]) {
  if (password.isEmpty) {
    return false;
  }

  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_-]'));
  bool hasMinLength = password.length >= minLength;

  return hasLowercase | hasSpecialCharacters | hasMinLength;
}

bool isValidReferralCode(String mobile, [int minLength = 11]) {
  if (mobile.isEmpty) {
    return false;
  }

  bool hasDigits = mobile.contains(RegExp(r'[0-9]'));
  bool hasSpecialCharacters =
      mobile.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_-]+'));
  bool hasMinLength = mobile.length >= minLength;

  return hasDigits & !hasSpecialCharacters & hasMinLength;
}

void setDataInSharedPreference(String keyValue, String dataValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(keyValue, dataValue);
}

getDataFromSharedPreference(String keyValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(keyValue);
}

String formatNumberString(String number) {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  mathFunc(Match match) => '${match[1]},';
  String formattedNumberString = number.replaceAllMapped(reg, mathFunc);
  return formattedNumberString;
}
