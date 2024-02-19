import 'package:dumbdumb_flutter_app/app/core/importers/importer_screens.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_structural.dart';
import 'package:dumbdumb_flutter_app/app/features/network/notifiers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// We subclassed "ConsumerWidget" instead of "StatelessWidget".
/// This is equivalent to making a "StatelessWidget" and retuning "Consumer".
class NetworkConsumerPage extends BaseConsumerWidget {
  const NetworkConsumerPage({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    /// We can use "ref.watch" inside our widget like we did using "Consumer"
    final userModel = ref.watch(userControllerProvider);
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
                              backgroundImage:
                                  value?.image?.isNotEmpty == true ? NetworkImage(value?.image ?? '') : null),
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
  AppBar? appBar() => AppBar(title: Text(S.current.network), centerTitle: true);
}
