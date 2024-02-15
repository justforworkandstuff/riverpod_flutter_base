import 'package:dumbdumb_flutter_app/app/model/itemModel/item_model.dart';
import 'package:dumbdumb_flutter_app/app/service/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// We extend ConsumerStatefulWidget.
/// This is the equivalent of "Consumer" + "StatefulWidget".
class DisplayConsumerStatefulPage extends ConsumerStatefulWidget {
  const DisplayConsumerStatefulPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

/// Notice how instead of "State", we are extending "ConsumerState".
/// This uses the same principle as "ConsumerWidget" vs "StatelessWidget".
class _HomeState extends ConsumerState<DisplayConsumerStatefulPage> {
  @override
  void initState() {
    super.initState();

    /// State life-cycles have access to "ref" too.
    /// This enables things such as adding a listener on a specific provider
    /// to show dialogs/snackbars.
    ref.listenManual(getItemModelProvider, (previous, next) {
      // TODO show a snackbar/dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    /// "ref" is not passed as parameter anymore, but is instead a property of "ConsumerState".
    /// We can therefore keep using "ref.watch" inside "build".
    final AsyncValue<ItemModel> itemModel = ref.watch(getItemModelProvider);

    return Center(
        child: switch (itemModel) {
      AsyncData(:final value) => Text('Data is: ${value.activity}'),
      AsyncError() => const Text('Opps, something wrong happened.'),
      _ => const CircularProgressIndicator()
    });
  }
}
