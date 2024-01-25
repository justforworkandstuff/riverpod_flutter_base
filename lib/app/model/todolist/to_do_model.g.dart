// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ToDoModelImpl _$$ToDoModelImplFromJson(Map<String, dynamic> json) =>
    _$ToDoModelImpl(
      description: json['description'] as String?,
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$$ToDoModelImplToJson(_$ToDoModelImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'completed': instance.completed,
    };
