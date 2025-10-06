import 'dart:io';

import 'package:task_manager/src/modals/priority.dart';
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
    return [
      PriorityLevel(
        0,
        title: "High",
        priority: Priority.high,
        color: Colors.red,
      ),
      PriorityLevel(
        1,
        title: "Medium",
        priority: Priority.medium,
        color: Colors.orange,
      ),
      PriorityLevel(
        2,
        title: "Low",
        priority: Priority.low,
        color: Colors.green,
      ),
    ];
  }

  static Future<DateTime?> setCalendar(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    return selectedDate;
  }

  static Future<String?> getTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    return selectedTime != null ? formatTimeOfDay(selectedTime) : null;
  }

  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final format = DateFormat.jm();
    return format.format(dateTime);
  }

  static String getDate(String? date) {
    if (date == null || date == "null" || date.isEmpty) {
      return "";
    }
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat("d MMM y").format(parsedDate);
    } catch (e) {
      return "";
    }
  }

  static String getFormattedDateTime(DateTime dateTime) {
    return DateFormat("d MMM y, h:mm a").format(dateTime);
  }

  static Color getPriorityColor(int level) {
    switch (level) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static String getPriorityText(int level) {
    switch (level) {
      case 0:
        return "High";
      case 1:
        return "Medium";
      case 2:
        return "Low";
      default:
        return "Unknown";
    }
  }
}
