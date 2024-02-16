import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/importers/importer_screens.dart';

class InitialPage extends BaseConsumerWidget {
  const InitialPage({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Counter'), Text('To-Do'), Text('Network')],
      ),
    );
  }
}
