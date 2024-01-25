import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    String? activity,
    int? participants,
    double? price,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, Object?> json) => _$ItemModelFromJson(json);
}
