import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';

class ItemSelectionWidget extends StatelessWidget {
  const ItemSelectionWidget({super.key, required this.itemTitle});

  final String itemTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(itemTitle),
            const Icon(Icons.arrow_right)
          ],
        ));
  }
}
