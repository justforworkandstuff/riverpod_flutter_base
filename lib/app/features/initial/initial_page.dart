import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/handlers/notification_handler.dart';
import 'package:dumbdumb_flutter_app/app/features/basePages/base_consumer_stateful_widget.dart';
import 'package:dumbdumb_flutter_app/app/features/initial/widgets/item_selection_widget.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InitialPage extends BaseConsumerStatefulWidget {
  const InitialPage({super.key});

  @override
  ConsumerState createState() => _InitialPageState();
}

class _InitialPageState extends BaseConsumerStatefulWidgetState<InitialPage> {
  @override
  void initState() {
    super.initState();
    NotificationHandler.checkForInitialMessage();
  }

  @override
  Widget body() {
    final itemList = [HomePages.counter, HomePages.todo, HomePages.network, HomePages.networkWithRefreshToken];

    return Center(
      child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => _actionNavigate(context, itemList[index].navigationPath),
              child: ItemSelectionWidget(itemTitle: itemList[index].displayName));
        },
      ),
    );
  }

  void _actionNavigate(BuildContext context, String navigationPath) {
    context.goNamed(navigationPath);
  }

  @override
  AppBar? appBar() => AppBar(title: Text(S.current.home), centerTitle: true);
}
