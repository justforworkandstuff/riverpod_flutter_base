// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'to_do_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ToDoModel _$ToDoModelFromJson(Map<String, dynamic> json) {
  return _ToDoModel.fromJson(json);
}

/// @nodoc
mixin _$ToDoModel {
  String? get description => throw _privateConstructorUsedError;
  bool? get completed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ToDoModelCopyWith<ToDoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToDoModelCopyWith<$Res> {
  factory $ToDoModelCopyWith(ToDoModel value, $Res Function(ToDoModel) then) =
      _$ToDoModelCopyWithImpl<$Res, ToDoModel>;
  @useResult
  $Res call({String? description, bool? completed});
}

/// @nodoc
class _$ToDoModelCopyWithImpl<$Res, $Val extends ToDoModel>
    implements $ToDoModelCopyWith<$Res> {
  _$ToDoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? completed = freezed,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      completed: freezed == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ToDoModelImplCopyWith<$Res>
    implements $ToDoModelCopyWith<$Res> {
  factory _$$ToDoModelImplCopyWith(
          _$ToDoModelImpl value, $Res Function(_$ToDoModelImpl) then) =
      __$$ToDoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? description, bool? completed});
}

/// @nodoc
class __$$ToDoModelImplCopyWithImpl<$Res>
    extends _$ToDoModelCopyWithImpl<$Res, _$ToDoModelImpl>
    implements _$$ToDoModelImplCopyWith<$Res> {
  __$$ToDoModelImplCopyWithImpl(
      _$ToDoModelImpl _value, $Res Function(_$ToDoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? completed = freezed,
  }) {
    return _then(_$ToDoModelImpl(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      completed: freezed == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ToDoModelImpl implements _ToDoModel {
  const _$ToDoModelImpl({this.description, this.completed = false});

  factory _$ToDoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ToDoModelImplFromJson(json);

  @override
  final String? description;
  @override
  @JsonKey()
  final bool? completed;

  @override
  String toString() {
    return 'ToDoModel(description: $description, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToDoModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, completed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToDoModelImplCopyWith<_$ToDoModelImpl> get copyWith =>
      __$$ToDoModelImplCopyWithImpl<_$ToDoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ToDoModelImplToJson(
      this,
    );
  }
}

abstract class _ToDoModel implements ToDoModel {
  const factory _ToDoModel({final String? description, final bool? completed}) =
      _$ToDoModelImpl;

  factory _ToDoModel.fromJson(Map<String, dynamic> json) =
      _$ToDoModelImpl.fromJson;

  @override
  String? get description;
  @override
  bool? get completed;
  @override
  @JsonKey(ignore: true)
  _$$ToDoModelImplCopyWith<_$ToDoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
