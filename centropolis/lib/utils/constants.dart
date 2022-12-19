import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

RegExp regex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

String capitalize(String string) {
  if (string == null) {
    throw ArgumentError("string: $string");
  }

  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}

String dateTimeConverter(date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  // var outputFormat = DateFormat('yyyy.MM.dd hh:mm a');
  var outputFormat;
  if (tr("lang") == "ko") {
    outputFormat = DateFormat('yyyy.MM.dd a hh:mm');
  } else {
    outputFormat = DateFormat('yyyy.MM.dd hh:mm a');
  }

  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

String dateConverter(date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('yyyy.MM.dd');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

String timeConverter(date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat;
  if (tr('lang') == 'en') {
    outputFormat = DateFormat('hh:mm a');
  } else {
    outputFormat = DateFormat('a hh:mm');
  }
  //var outputFormat = DateFormat('hh:mm a');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

String base64Enecode(String id) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encoded = stringToBase64.encode(id); // dXNlcm5hbWU6cGFzc3dvcmQ=
  return encoded;
}

class ConstantsData {
  static const dummy = 'dummy';
}

class TimeAgo {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true}) {
    final DateTime time1 = DateTime.parse(dateString);
    String newDate = DateFormat("dd-MM-yyyy h:mma").format(time1).toString();
    DateTime notificationDate = DateFormat("dd-MM-yyyy h:mma").parse(newDate);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return newDate;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String timeAgo(String timestamp) {
    if (kDebugMode) {
      print(timestamp);
    }
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    //DateTime EastCoast = dateTimeToZone(zone: "EST", datetime: myDT);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = '$timeValue $timeUnit';
    timeAgo += timeValue > 1 ? 's' : '';

    return '$timeAgo ago';
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
