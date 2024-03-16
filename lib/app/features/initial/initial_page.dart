import 'package:dumbdumb_flutter_app/app/common/constants/enums.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_screens.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_structural.dart';

class InitialPage extends BaseConsumerWidget {
  const InitialPage({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final itemList = [HomePages.counter, HomePages.todo, HomePages.network, HomePages.networkWithRefreshToken];

    return Center(
      child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => _actionNavigate(context, itemList[index].navigationPath),
              child: ItemSelectionWidget(itemTitle: itemList[index].displayName));
        },
      ),
    );
  }

  void _actionNavigate(BuildContext context, String navigationPath) {
    context.goNamed(navigationPath);
  }

  @override
  AppBar? appBar() => AppBar(title: Text(S.current.home), centerTitle: true);
}
