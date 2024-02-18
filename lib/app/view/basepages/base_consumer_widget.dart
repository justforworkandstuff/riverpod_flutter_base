import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';

abstract class BaseConsumerWidget extends ConsumerWidget {
  const BaseConsumerWidget({super.key});

  /// Common attributes
  bool isTopSafeAreaEnabled() => true;

  bool isBottomSafeAreaEnabled() => true;

  /// Common widgets
  AppBar? appBar() => null;

  Widget? floatingActionButton(WidgetRef ref) => null;

  BottomNavigationBar? bottomNavigationBar() => null;

  Widget body(BuildContext context, WidgetRef ref);

  /// Each Page are meant to be build with a [Scaffold] structure
  /// include with [AppBar], [Body], [FloatingActionButton]
  /// so that all inheriting classes would not needed to handle it repeatedly.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      /// Added this to disallow showing of glow effect when over-scrolled
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: Scaffold(
          appBar: appBar(),
          body: SafeArea(top: isTopSafeAreaEnabled(), bottom: isBottomSafeAreaEnabled(), child: body(context, ref)),
          floatingActionButton: floatingActionButton(ref),
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: bottomNavigationBar(),
        ),
      ),
    );
  }
}
