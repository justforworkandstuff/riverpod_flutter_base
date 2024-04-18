import 'package:dumbdumb_flutter_app/app/features/basePages/base_consumer_widget.dart';
import 'package:dumbdumb_flutter_app/app/features/network/controllers/user_controller.dart';
import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/providers/network_provider.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// We subclassed "ConsumerWidget" instead of "StatelessWidget".
/// This is equivalent to making a "StatelessWidget" and retuning "Consumer".
class NetworkConsumerPage extends BaseConsumerWidget {
  const NetworkConsumerPage({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    /// We can use "ref.watch" inside our widget like we did using "Consumer"
    final UserModel? userModel = ref.watch(userControllerProvider);
    return Center(
        child: RefreshIndicator(
            onRefresh: () async => ref.read(userControllerProvider.notifier).getUser(),
            child: userModel != null
                ? CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  ref.read(userControllerProvider.notifier).getUserImage(ref.read(userServiceProvider)),
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  backgroundImage: userModel.profileImage?.isNotEmpty == true
                                      ? NetworkImage(userModel.profileImage ?? '')
                                      : null),
                            ),
                            const SizedBox(height: 100),
                            Container(alignment: Alignment.center, child: Text(S.current.nameIs(userModel.name ?? ''))),
                          ],
                        ),
                      )
                    ],
                  )
                : Text(S.current.generalError)));
  }

  @override
  AppBar? appBar() => AppBar(title: Text(S.current.network), centerTitle: true);

  @override
  FloatingActionButton floatingActionButton(WidgetRef ref, BuildContext context) => FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        ref.read(userControllerProvider.notifier).getUser();
      });
}
