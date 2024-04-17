import 'package:dumbdumb_flutter_app/app/common/exceptions/custom_exception.dart';
import 'package:dumbdumb_flutter_app/app/features/basePages/base_consumer_widget.dart';
import 'package:dumbdumb_flutter_app/app/features/network/model/user_model.dart';
import 'package:dumbdumb_flutter_app/app/features/network/notifiers/user_controller.dart';
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
    final AsyncValue<UserModel?> userModel = ref.watch(userControllerProvider);
    return Center(
      child: RefreshIndicator(
          onRefresh: () async => ref.read(userControllerProvider.notifier).getUser(),
          child: userModel.when(
              data: (value) => CustomScrollView(
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
              error: (object, stackTrace) {
                if (object is CustomException) {
                  return Text(object.error.getErrorMessage().toString());
                }
                return Text(S.current.generalError);
              },
              loading: () => const CircularProgressIndicator())),
    );
  }

  @override
  AppBar? appBar() => AppBar(title: Text(S.current.network), centerTitle: true);
}
