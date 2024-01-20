// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      activity: json['activity'] as String?,
      participants: json['participants'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'participants': instance.participants,
      'price': instance.price,
    };
