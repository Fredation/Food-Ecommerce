// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'store_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StoreState {
  dynamic get isLoading => throw _privateConstructorUsedError;
  Failure? get error => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StoreStateCopyWith<StoreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreStateCopyWith<$Res> {
  factory $StoreStateCopyWith(
          StoreState value, $Res Function(StoreState) then) =
      _$StoreStateCopyWithImpl<$Res>;
  $Res call({dynamic isLoading, Failure? error, dynamic data});
}

/// @nodoc
class _$StoreStateCopyWithImpl<$Res> implements $StoreStateCopyWith<$Res> {
  _$StoreStateCopyWithImpl(this._value, this._then);

  final StoreState _value;
  // ignore: unused_field
  final $Res Function(StoreState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? error = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_StoreStateCopyWith<$Res>
    implements $StoreStateCopyWith<$Res> {
  factory _$$_StoreStateCopyWith(
          _$_StoreState value, $Res Function(_$_StoreState) then) =
      __$$_StoreStateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic isLoading, Failure? error, dynamic data});
}

/// @nodoc
class __$$_StoreStateCopyWithImpl<$Res> extends _$StoreStateCopyWithImpl<$Res>
    implements _$$_StoreStateCopyWith<$Res> {
  __$$_StoreStateCopyWithImpl(
      _$_StoreState _value, $Res Function(_$_StoreState) _then)
      : super(_value, (v) => _then(v as _$_StoreState));

  @override
  _$_StoreState get _value => super._value as _$_StoreState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? error = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_StoreState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_StoreState implements _StoreState {
  const _$_StoreState({this.isLoading = false, this.error, this.data});

  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final Failure? error;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'StoreState(isLoading: $isLoading, error: $error, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoreState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$_StoreStateCopyWith<_$_StoreState> get copyWith =>
      __$$_StoreStateCopyWithImpl<_$_StoreState>(this, _$identity);
}

abstract class _StoreState implements StoreState {
  const factory _StoreState(
      {final dynamic isLoading,
      final Failure? error,
      final dynamic data}) = _$_StoreState;

  @override
  dynamic get isLoading;
  @override
  Failure? get error;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$_StoreStateCopyWith<_$_StoreState> get copyWith =>
      throw _privateConstructorUsedError;
}
