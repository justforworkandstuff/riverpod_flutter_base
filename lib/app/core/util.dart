import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class WidgetUtil {
  static Future<dynamic> showAlertDialog(BuildContext context,
      {String? title, String? content, List<Widget>? actions, bool? dismissible = false, Widget? customWidget}) async {
    return await showAdaptiveDialog<void>(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) => AlertDialog.adaptive(
            title: Text(title.toString()), content: customWidget ?? Text(content.toString()), actions: actions));
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
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
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
  String toJson() {
    try {
      return jsonEncode(this);
    } catch (_) {
      return '';
    }
  }

  Map<String, dynamic> fromJson() {
    try {
      return jsonDecode(this) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
}

extension StringExt on String? {
  String capitalize() => this?.isNotEmpty == true ? this![0].toUpperCase() + this!.substring(1) : this ?? '';

  String allCap() => this?.isNotEmpty == true ? this!.characters.map((e) => e.toUpperCase()).join() : this ?? '';

  bool isValidPhoneNumber() => RegExp(r'(^[0-9]{9,10}$)').hasMatch(this ?? '');

  bool isValidPassword() =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~)%\-(_+=/?^]).{6,}$').hasMatch(this ?? '');

  bool isValidEmail() =>
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this ?? '');

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

    /// Needed as [device_info_plugin] package has removed support to get
    /// Android device's unique id in ^4.0.0 and above.
    /// Ref: https://pub.dev/packages/device_info_plus/changelog#410
    AndroidId androidId = const AndroidId();
    if (kIsWeb) {
      const uuid = Uuid();
      return uuid.v4();
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return await androidId.getId() ?? '';
        case TargetPlatform.fuchsia:
          return 'getDeviceId has not been configured for fuchsia.';
        case TargetPlatform.iOS:
          return await deviceInfo.iosInfo.then((value) => value.identifierForVendor ?? '');
        case TargetPlatform.linux:
          return 'getDeviceId has not been configured for linux.';
        case TargetPlatform.macOS:
          return 'getDeviceId has not been configured for macOS.';
        case TargetPlatform.windows:
          return 'getDeviceId has not been configured for windows.';
        default:
          return '';
      }
    }
  }
}
