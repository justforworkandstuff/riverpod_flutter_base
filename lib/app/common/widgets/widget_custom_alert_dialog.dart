import 'package:flutter/material.dart';

class WidgetCustomAlertDialog extends StatelessWidget {
  const WidgetCustomAlertDialog(
      {super.key, this.title, this.content, this.actions, this.dismissible = false, this.customWidget});

  final String? title;
  final String? content;
  final List<Widget>? actions;
  final bool? dismissible;
  final Widget? customWidget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
        title: Text(title.toString()), content: customWidget ?? Text(content.toString()), actions: actions);
  }
}
