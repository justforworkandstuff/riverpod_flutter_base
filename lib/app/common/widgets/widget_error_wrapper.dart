import 'dart:io';

import 'package:dumbdumb_flutter_app/app/common/exceptions/custom_exception.dart';
import 'package:dumbdumb_flutter_app/app/core/util.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Error wrapper widget to handle unauthorized errors for AsyncValue.error
class WidgetErrorWrapper extends StatefulWidget {
  const WidgetErrorWrapper(this.error, {super.key, this.customErrorWidget});

  final Object error;
  final Widget? customErrorWidget;

  @override
  State<WidgetErrorWrapper> createState() => _WidgetErrorWrapperState();
}

class _WidgetErrorWrapperState extends State<WidgetErrorWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.error is CustomException &&
          (widget.error as CustomException).error.errorCode == HttpStatus.unauthorized) {
        final actions = List<Widget>.empty(growable: true)
          ..add(CommonActionsUtil.getDialogButton(S.current.ok, () => Navigator.of(context).pop()));
        CommonActionsUtil.showAlertDialog(context,
            title: S.current.sessionExpired, content: S.current.pleaseLoginAgain, actions: actions, dismissible: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.customErrorWidget ?? const SizedBox.shrink();
  }
}
