import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetUtil {
  static void showAlertDialog(
      BuildContext context, String? title, String? content, List<Widget> actions, bool dismissible) {
    showDialog<void>(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) => Platform.isAndroid
            ? getMaterialDialog(title, content, actions)
            : getCupertinoDialog(title, content, actions));
  }

  static Widget getCupertinoDialog(String? title, String? content, List<Widget> actions) {
    return CupertinoAlertDialog(
      title: Text(title ?? ''),
      content: Text(content ?? ''),
      actions: actions,
    );
  }

  static Widget getMaterialDialog(String? title, String? content, List<Widget> actions) {
    return AlertDialog(
      title: Text(title ?? ''),
      content: Text(content ?? ''),
      actions: actions,
    );
  }

  static Widget getDialogButton(String text, VoidCallback? onPressed) {
    return Platform.isAndroid
        ? TextButton(onPressed: onPressed, child: Text(text))
        : CupertinoDialogAction(
            onPressed: onPressed,
            child: Text(text),
          );
  }

  static double getScaleFactor(BuildContext context) => min(MediaQuery.of(context).textScaler.scale(1.0), 1.0);

  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)))
        .closed
        .then((_) => ScaffoldMessenger.of(context).clearSnackBars());
  }
}

extension DynamicParsing on dynamic {
  String parseString() => this != null ? toString() : '';

  int parseInt() => this != null ? (int.tryParse(toString()) ?? 0) : 0;

  double parseDouble() => this != null ? (double.tryParse(toString()) ?? 0.0) : 0.0;

  bool parseBool() {
    if (this != null) {
      return this as bool;
    } else {
      return false;
    }
  }
}

extension JsonParsing on dynamic {
  String toJson() => jsonEncode(this);

  Map<String, dynamic> fromJson() => jsonDecode(this) as Map<String, dynamic>;
}

extension StringExt on String? {
  String capitalize() => this?.isNotEmpty == true ? this![0].toUpperCase() + this!.substring(1) : this ?? '';

  String allCap() => this?.isNotEmpty == true ? this!.characters.map((e) => e.toUpperCase()).join() : this ?? '';

  bool isValidPhoneNumber() => RegExp(r'(^[0-9]{9,10}$)').hasMatch(this ?? '');

  bool isValidPassword() =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~)\%\-(_+=/?^]).{6,}$').hasMatch(this ?? '');

  bool isValidEmail() =>
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this ?? '');

  bool isNumeric() => num.tryParse(this ?? '') != null;

  String parseDateDDMMMYYYY() {
    var parsed = DateTime.tryParse(this ?? '');
    if (parsed != null) {
      return DateFormat('dd MMM yyyy').format(parsed);
    }
    return '';
  }
}

extension DateTimeParsing on DateTime {
  String withFormat(String formatString) {
    return DateFormat(formatString).format(this).toString();
  }
}

extension BytesExt on int {
  static const rate = 1024;

  double toMb() {
    return (this / rate) / rate;
  }
}

class DeviceChecking {
  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return Platform.isIOS
        ? await deviceInfo.iosInfo.then((value) => value.identifierForVendor ?? '')
        : await deviceInfo.androidInfo.then((value) => value.id);
  }
}
