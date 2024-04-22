import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dumbdumb_flutter_app/app/common/widgets/widget_custom_alert_dialog.dart';
import 'package:dumbdumb_flutter_app/app/core/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CommonActionsUtil {
  static Future<dynamic> showAlertDialog(BuildContext context,
      {String? title, String? content, List<Widget>? actions, bool? dismissible = false, Widget? customWidget}) async {
    return await showAdaptiveDialog<void>(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) => WidgetCustomAlertDialog(
            title: title.toString(),
            content: content,
            actions: actions,
            dismissible: dismissible,
            customWidget: customWidget));
  }

  static Widget getDialogButton(String text, VoidCallback? onPressed) {
    return Platform.isAndroid
        ? TextButton(onPressed: onPressed, child: Text(text))
        : CupertinoDialogAction(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext ?? context).clearSnackBars();
    ScaffoldMessenger.of(AppRouter.navigatorKey.currentContext ?? context).showSnackBar(SnackBar(content: Text(text)));
  }
}

extension DynamicParsing on dynamic {
  String parseString() => this != null ? toString() : '';

  int parseInt() => this != null ? (int.tryParse(toString()) ?? 0) : 0;

  double parseDouble() => this != null ? (double.tryParse(toString()) ?? 0.0) : 0.0;

  bool parseBool() {
    if (this != null) {
      return bool.tryParse(toString()) ?? false;
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

extension StringExtension on String {
  String capitalize() => isNotEmpty == true ? this[0].toUpperCase() + substring(1) : this;

  String allCap() => isNotEmpty == true ? characters.map((e) => e.toUpperCase()).join() : this;

  /// Valid Phone number where:
  /// - Length should be either 7-10
  bool isValidPhoneNumber() => RegExp(r'(^[0-9]{7,10}$)').hasMatch(this);

  /// Requirement of:
  /// - At least 1 uppercase letter (A-Z)
  /// - At least 1 lowercase letter (a-z)
  /// - At lease 1 digit (0-9)
  /// - At least 1 special characters (!@#$&*~)%-(_+=/?^.)
  /// - Minimum length of 6
  bool isValidPassword() => RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[^\w\s:]).{6,}$').hasMatch(this);

  /// Requirement of:
  /// - Should be able to include alphanumeric characters (A-Z, a-z, 0-9) and certain special characters (!#$%&'*+-/=?^_`{|}~) before the '@'
  /// - Should have a '@' symbol
  /// - Should be able to include alphanumeric characters (A-Z, a-z, 0-9) for the domain name (after the '@')
  /// - Should have a dot (.) separating the domain name from the top-level domain (TLD)
  /// - Should be able to include alphabetical characters (A-Z, a-z) for the top-level domain (after the '.')
  bool isValidEmail() => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  bool isNumeric() => num.tryParse(this) != null;

  String parseTimeOnly() {
    final parsed = DateTime.tryParse(this);
    if (parsed != null) {
      return DateFormat.Hm().format(parsed);
    }
    return '';
  }

  String parseUTCDate({String? dateFormat = 'yyyy-MM-dd HH:mm:ss'}) {
    final parsed = DateTime.tryParse(this);
    final local = parsed?.toLocal();
    if (local != null) {
      return DateFormat(dateFormat).format(local);
    }
    return '';
  }

  bool get isNullOrEmptyOrBlank => isNotEmpty == true ? replaceAll(' ', '').isEmpty : true;
}

extension DateTimeParsing on DateTime {
  String withFormat(String formatString) {
    return DateFormat(formatString).format(this);
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
