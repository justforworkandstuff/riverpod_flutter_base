import 'package:dumbdumb_flutter_app/app/common/widgets/widget_error_wrapper.dart';
import 'package:dumbdumb_flutter_app/app/features/basePages/base_consumer_stateful_widget.dart';
import 'package:dumbdumb_flutter_app/app/features/network/controllers/user_controller_with_refresh_token_flow.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkConsumerStatefulWidget extends BaseConsumerStatefulWidget {
  const NetworkConsumerStatefulWidget({super.key});

  @override
  BaseConsumerStatefulWidgetState createState() => _NetworkConsumerStatefulWidgetState();
}

class _NetworkConsumerStatefulWidgetState extends BaseConsumerStatefulWidgetState<NetworkConsumerStatefulWidget> {
  @override
  Widget body() {
    /// We can use "ref.watch" inside our widget like we did using "Consumer"
    final userModel = ref.watch(userControllerWithRefreshTokenFlowProvider);
    return Center(
        child: RefreshIndicator(
            onRefresh: () async => ref.read(userControllerWithRefreshTokenFlowProvider.notifier).getUser(),
            child: userModel.when(
              data: (value) => CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => ref.read(userControllerWithRefreshTokenFlowProvider.notifier).getUserImage(),
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage: value?.profileImage?.isNotEmpty == true
                                  ? NetworkImage(value?.profileImage ?? '')
                                  : null),
                        ),
                        const SizedBox(height: 100),
                        Container(alignment: Alignment.center, child: Text(S.current.nameIs(value?.name ?? ''))),
                      ],
                    ),
                  )
                ],
              ),
              error: (err, stack) => WidgetErrorWrapper(err, customErrorWidget: (Text(S.current.generalError))),
              loading: () => const CircularProgressIndicator(),
            )));
  }

  @override
  AppBar? appBar() => AppBar(title: Text(S.current.networkWithRefreshToken), centerTitle: true);
}
