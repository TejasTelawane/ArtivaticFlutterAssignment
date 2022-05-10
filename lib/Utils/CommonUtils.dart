import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import 'StringUtil.dart';

class CommonUtils {
  static showToast(String title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<DateTime?> DatePickerforDob(
      BuildContext context, DateTime datetime) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: datetime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    return picked;
  }

  static int generateRandomNumber() {
    int min = 10000000;
    int max = 99999999;
    String datePart = "";
    String reqrefnum = "";
    int rndNumber = 0;
    Random rnd = Random.secure();
    rndNumber = min + rnd.nextInt(max - min);
    return rndNumber;
  }

  static Future<String?> getDeviceUniqueId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static Future<String?> getDeviceName() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return 'IOS ~ ${iosDeviceInfo.name}_${iosDeviceInfo.systemVersion}'; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return 'Android ~ ${androidDeviceInfo.brand}_${androidDeviceInfo.model}'; // unique ID on Android
    }
  }

  static String getMonthasNumber(String month) {
    DateTime tempDate = DateFormat("MMMM").parse(month);
    String date = DateFormat("MM").format(tempDate);
    return date;
  }

  static List<String> getLast10yearList() {
    List<String> YearList = [];
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy');
    int currentyear = int.parse(formatter.format(now));
    int minYear = currentyear - 10;

    for (int i = currentyear; i > minYear; i--) {
      YearList.add('${i}');
    }
    return YearList;
  }

  static List<String> GetMonthArrayListForCurrentYear() {
    List<String> MonthList = [];
    DateTime now = DateTime.now();
    String CurrentMonth = DateFormat('MMMM').format(now);
    List<String> FullMonthAryList = GetFullMonthsArrayList();
    for (int i = 0; i < FullMonthAryList.length; i++) {
      MonthList.add(FullMonthAryList[i]);
      if (StringUtil.CheckEqualIgnoreCase(CurrentMonth, FullMonthAryList[i])) {
        break;
      }
    }
    return MonthList;
  }

  static List<String> GetFullMonthsArrayList() {
    List<String> MonthList = [];
    MonthList.add('January');
    MonthList.add('February');
    MonthList.add('March');
    MonthList.add('April');
    MonthList.add('May');
    MonthList.add('June');
    MonthList.add('July');
    MonthList.add('August');
    MonthList.add('September');
    MonthList.add('October');
    MonthList.add('November');
    MonthList.add('December');
    return MonthList;
  }
}
