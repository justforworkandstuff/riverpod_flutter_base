import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_screens.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_structural.dart';
import 'package:dumbdumb_flutter_app/app/features/counter/controllers/counter_controller.dart';

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
