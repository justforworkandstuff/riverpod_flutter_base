import 'package:dumbdumb_flutter_app/app/core/importers/importer_screens.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_structural.dart';
import 'package:dumbdumb_flutter_app/app/features/network/notifiers/user_controller.dart';
import 'package:dumbdumb_flutter_app/app/features/network/notifiers/user_controller_with_refresh_token_flow.dart';
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
          onRefresh: () async => ref.read(userControllerProvider.notifier).getUser(),
          child: switch (userModel) {
            AsyncData(:final value) => CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => ref.read(userControllerProvider.notifier).getUserImage(),
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
            AsyncError() => Text(S.current.generalError),
            _ => const CircularProgressIndicator()
          }),
    );
  }

  @override
  AppBar? appbar() => AppBar(title: Text(S.current.networkWithRefreshToken), centerTitle: true);
}
