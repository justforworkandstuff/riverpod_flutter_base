import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';

class NetworkPage extends ConsumerWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}

// import 'package:dumbdumb_flutter_app/app/model/itemModel/item_model.dart';
// import 'package:dumbdumb_flutter_app/app/service/providers/providers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class NetworkPage extends StatefulWidget {
//   const NetworkPage({super.key});
//
//   @override
//   State<NetworkPage> createState() => _NetworkPageState();
// }
//
// class _NetworkPageState extends State<NetworkPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
//       /// Read the activityProvider. This will start the network request
//       /// if it wasn't already started.
//       /// By using ref.watch, this widget will rebuild whenever the
//       /// the activityProvider updates. This can happen when:
//       /// - The response goes from "loading" to "data/error"
//       /// - The request was refreshed
//       /// - The result was modified locally (such as when performing side-effects)
//       final AsyncValue<ItemModel> itemModel = ref.watch(getItemModelProvider);
//
//       /// Since network-requests are asynchronous and can fail, we need to
//       /// handle both error and loading states. We can use pattern matching for this.
//       /// We could alternatively use `if (activity.isLoading) { ... } else if (...)`
//       return Center(
//           child: switch (itemModel) {
//         AsyncData(:final value) => Text('Data is: ${value.activity}'),
//         AsyncError() => const Text('Opps, something wrong happened.'),
//         _ => const CircularProgressIndicator()
//       });
//     }));
//   }
// }