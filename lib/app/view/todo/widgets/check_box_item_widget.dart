import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';

class CheckBoxItemWidget extends StatefulWidget {
  const CheckBoxItemWidget({super.key, required this.itemTitle, required this.action});

  final String itemTitle;
  final Function(bool) action;

  @override
  State<CheckBoxItemWidget> createState() => _CheckBoxItemWidgetState();
}

class _CheckBoxItemWidgetState extends State<CheckBoxItemWidget> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.itemTitle),
            Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() => _isChecked = !_isChecked);
                widget.action(_isChecked);
              },
            )
          ],
        ));
  }
}
