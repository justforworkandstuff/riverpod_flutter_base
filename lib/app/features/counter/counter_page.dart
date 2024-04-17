import 'package:dumbdumb_flutter_app/app/features/basePages/base_consumer_widget.dart';
import 'package:dumbdumb_flutter_app/app/features/counter/controllers/counter_controller.dart';
import 'package:dumbdumb_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends BaseConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final int counterValue = ref.watch(counterControllerProvider);

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(S.current.counterText), Text(counterValue.toString())],
    ));
  }

  @override
  AppBar? appBar() {
    return AppBar(
      title: Text(S.current.counter),
      centerTitle: true,
    );
  }

  @override
  Widget? floatingActionButton(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
            onPressed: () {
              ref.read(counterControllerProvider.notifier).increment();
            },
            child: const Icon(Icons.add)),
        const SizedBox(width: 10),
        FloatingActionButton(
            onPressed: () {
              ref.read(counterControllerProvider.notifier).decrement();
            },
            child: const Icon(Icons.remove)),
      ],
    );
  }
}
