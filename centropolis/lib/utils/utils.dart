import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/common_modal.dart';
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

void showErrorCommonModal({context, heading, description, buttonName}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CommonModal(
          heading: heading,
          description: description,
          buttonName: buttonName,
          firstButtonName: "",
          secondButtonName: "",
          onConfirmBtnTap: () {
            Navigator.pop(context);
          },
          onFirstBtnTap: () {},
          onSecondBtnTap: () {},
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
  //newly updated validation code
  bool userIdValid = false;
  if (userId != "") {
    userIdValid = RegExp(
            r"^(?!^[0-9])(?=.[a-z0-9!@#$%^&()._])[a-z0-9!@#$%^&*()._]{4,16}$")
        .hasMatch(userId);
  }
  return userIdValid;
  // if (userId.isEmpty) {
  //   return false;
  // }

  // if (userId.contains(RegExp(r'[A-Z]')) ||
  //     userId.contains(' ') 
  //     ||
  //     userId.contains(RegExp(r'[,?":{}|<>-]'))
  //     // userId.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_-]'))
  //     ) {
  //   return false;
  // } else {
  //   bool hasDigits = userId.contains(RegExp(r'[0-9]'));
  //   bool hasLowercase = userId.contains(RegExp(r'[a-z]'));
  //   bool hasMinLength = userId.length >= 4;
  //   bool hasMaxLength = userId.length <= 16;
  //   bool hasMatch = RegExp("[a-z0-9]").hasMatch(userId);

  //   return (hasDigits &&
  //           hasLowercase & hasMaxLength & hasMinLength &&
  //           hasMatch) ||
  //       (hasLowercase & hasMaxLength & hasMinLength && hasMatch);
  // }
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

String formatNumberStringWithComma(String number) {
  if (number.isNotEmpty) {
    if (!number.contains(",")) {
      RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      mathFunc(Match match) => '${match[1]},';
      String formattedNumberString = number.replaceAllMapped(reg, mathFunc);
      return formattedNumberString;
    } else {
      return number;
    }
  } else {
    return "";
  }
}

String formatNumberStringWithDash(String number) {
  if (number.isNotEmpty) {
    if (!number.contains("-")) {
      RegExp reg = RegExp(r'(\d{3})(\d{4})(\d+)');
      mathFunc(Match match) => '${match[1]}-${match[2]}-${match[3]}';
      String formattedNumberString = number.replaceAllMapped(reg, mathFunc);
      return formattedNumberString;
    } else {
      return number;
    }
  } else {
    return "";
  }
}

String formatStringWithSquareBrackets(String text) {
  if (text.isNotEmpty) {
    if (text.contains("[") || text.contains("]")) {
      final removedBrackets = text.substring(1, text.length - 1);
      return removedBrackets;
    } else {
      return text;
    }
  } else {
    return "";
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeByWord() {
    if (trim().isEmpty) {
      return '';
    }
    return split(' ')
        .map((element) =>
            "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}")
        .join(" ");
  }
}

int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
}

String getOrdinalDay(int day, String language) {
  if (language == 'ko') {
    return '$day';
  }
  if (day == 11 || day == 12 || day == 13) {
    return '${day}th';
  }
  if (day % 10 == 1) {
    return '${day}st';
  }
  if (day % 10 == 2) {
    return '${day}nd';
  }
  if (day % 10 == 3) {
    return '${day}rd';
  }
  return '${day}th';
}
