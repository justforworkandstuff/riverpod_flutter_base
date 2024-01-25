import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';

part 'to_do_model.freezed.dart';
part 'to_do_model.g.dart';

@freezed
class ToDoModel with _$ToDoModel {
  const factory ToDoModel({
    String? description,
    @Default(false) bool? completed}) = _ToDoModel;

  factory ToDoModel.fromJson(Map<String, Object?> json) => _$ToDoModelFromJson(json);
}
