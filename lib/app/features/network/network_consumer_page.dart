// import 'package:dumbdumb_flutter_app/app/model/itemModel/item_model.dart';
// import 'package:dumbdumb_flutter_app/app/service/providers/providers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// /// We subclassed "ConsumerWidget" instead of "StatelessWidget".
// /// This is equivalent to making a "StatelessWidget" and retuning "Consumer".
// class NetworkConsumerPage extends ConsumerWidget {
//   const NetworkConsumerPage({super.key});
//
//   @override
//   /// Notice how "build" now receives an extra parameter: "ref"
//   Widget build(BuildContext context, WidgetRef ref) {
//     /// We can use "ref.watch" inside our widget like we did using "Consumer"
//     final AsyncValue<ItemModel> itemModel = ref.watch(getItemModelProvider);
//     return Center(
//         child: switch (itemModel) {
//       AsyncData(:final value) => Text('Data is: ${value.activity}'),
//       AsyncError() => const Text('Opps, something wrong happened.'),
//       _ => const CircularProgressIndicator()
//     });
//   }
// }
