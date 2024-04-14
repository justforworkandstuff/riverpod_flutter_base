import 'package:freezed_annotation/freezed_annotation.dart';

part 'to_do_model.g.dart';
part 'to_do_model.freezed.dart';

@freezed
class ToDoModel with _$ToDoModel {
  const factory ToDoModel({
    String? description,
    @Default(false) bool? completed}) = _ToDoModel;

  factory ToDoModel.fromJson(Map<String, Object?> json) => _$ToDoModelFromJson(json);
}
