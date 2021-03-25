import 'dart:io';

import 'package:firebasechat/src/modals/priority.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonUtils {

  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static List<PriorityLevel> createPriorityList() {
    List<PriorityLevel> list = [];

    list.add(PriorityLevel(0,
        title: "High", priority: Priority.High, color: Colors.red));
    list.add(PriorityLevel(1,
        title: "Medium", priority: Priority.Medium, color: Colors.green));
    list.add(PriorityLevel(2,
        title: "Low", priority: Priority.Low, color: Colors.blueAccent));

    return list;
  }

  static Future<DateTime> setCalender(BuildContext context) async {
    final DateTime selectDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2200));

    return selectDate;
  }

  static Future<String> getTime(BuildContext context) async {
    final TimeOfDay selectTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    return formatTimeOfDay(selectTime);
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  static String getDate(String date) {
    if (date == "null") {
      return "";
    }
    var _date = DateTime.parse(date);
    return new DateFormat("d MMM y").format(_date);
  }
}
