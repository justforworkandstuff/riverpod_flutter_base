
import 'package:dumbdumb_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../model/error_model.dart';
import '../../utils/util.dart';

/// A base class to unified all the required common functions and widgets
/// Inherited the StatelessWidget that does not required changes and user interaction
/// more info: https://docs.flutter.dev/development/ui/interactive#stateful-and-stateless-widgets
abstract class BaseStatelessPage extends StatelessWidget {

  late BuildContext context;

  //Devices Settings
  Size size() => MediaQuery.of(context).size;
  double width() => size().width;
  double height() => size().height;

  //Common functions
  void onBackPressed() => Navigator.pop(context);
  bool shouldShowLoading = false;

  //Common widgets
  AppBar? appbar() => null;
  Widget body();
  Widget? floatingActionButton() => null;
  BottomNavigationBar? bottomNavigationBar() => null;
  ErrorModel? urgentError() => null;

  /// Each Page are meant to be build with a [Scaffold] structure
  /// include with [AppBar], [Body], [FloatingActionButton]
  /// Additional handling for [urgentError] is included here,
  /// so that all inheriting classes would not needed to handle it repeatedly.
  @override
  Widget build(BuildContext context) {
    this.context = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(urgentError()?.forbidden() == true) {
        final actions = List<Widget>.empty(growable: true)
          ..add(WidgetUtil.getDialogButton(S.current.textOk, () {
            Navigator.of(context, rootNavigator: true).pop();
          }));
        WidgetUtil.showAlertDialog(context, S.current.errorTitle, urgentError()?.getErrorMessage(), actions, false);
      }
    });

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: Scaffold(
          appBar: appbar(),
          body: SafeArea(
            top: true,
            bottom: true,
            child: Stack(
                children: [
                  body(),
                  _widgetLoadingOverlay()
                ]
            ),
          ),
          floatingActionButton: floatingActionButton(),
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: bottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _widgetLoadingOverlay() {
    return Visibility(
        visible: shouldShowLoading,
        child: Container(
            width: width(),
            height: height(),
            color: Colors.transparent,
            child: Center(child: CircularProgressIndicator())));
  }
}