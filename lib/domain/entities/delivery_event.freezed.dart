// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DeliveryEvent _$DeliveryEventFromJson(Map<String, dynamic> json) {
  return _DeliveryEvent.fromJson(json);
}

/// @nodoc
mixin _$DeliveryEvent {
  DeliveryStatus get status => throw _privateConstructorUsedError;
  DateTime get at => throw _privateConstructorUsedError; // UTC
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  /// Serializes this DeliveryEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeliveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryEventCopyWith<DeliveryEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryEventCopyWith<$Res> {
  factory $DeliveryEventCopyWith(
    DeliveryEvent value,
    $Res Function(DeliveryEvent) then,
  ) = _$DeliveryEventCopyWithImpl<$Res, DeliveryEvent>;
  @useResult
  $Res call({DeliveryStatus status, DateTime at, double lat, double lng});
}

/// @nodoc
class _$DeliveryEventCopyWithImpl<$Res, $Val extends DeliveryEvent>
    implements $DeliveryEventCopyWith<$Res> {
  _$DeliveryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? at = null,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DeliveryStatus,
            at: null == at
                ? _value.at
                : at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeliveryEventImplCopyWith<$Res>
    implements $DeliveryEventCopyWith<$Res> {
  factory _$$DeliveryEventImplCopyWith(
    _$DeliveryEventImpl value,
    $Res Function(_$DeliveryEventImpl) then,
  ) = __$$DeliveryEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeliveryStatus status, DateTime at, double lat, double lng});
}

/// @nodoc
class __$$DeliveryEventImplCopyWithImpl<$Res>
    extends _$DeliveryEventCopyWithImpl<$Res, _$DeliveryEventImpl>
    implements _$$DeliveryEventImplCopyWith<$Res> {
  __$$DeliveryEventImplCopyWithImpl(
    _$DeliveryEventImpl _value,
    $Res Function(_$DeliveryEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeliveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? at = null,
    Object? lat = null,
    Object? lng = null,
  }) {
    return _then(
      _$DeliveryEventImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DeliveryStatus,
        at: null == at
            ? _value.at
            : at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryEventImpl implements _DeliveryEvent {
  const _$DeliveryEventImpl({
    required this.status,
    required this.at,
    required this.lat,
    required this.lng,
  });

  factory _$DeliveryEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryEventImplFromJson(json);

  @override
  final DeliveryStatus status;
  @override
  final DateTime at;
  // UTC
  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'DeliveryEvent(status: $status, at: $at, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryEventImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, at, lat, lng);

  /// Create a copy of DeliveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryEventImplCopyWith<_$DeliveryEventImpl> get copyWith =>
      __$$DeliveryEventImplCopyWithImpl<_$DeliveryEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryEventImplToJson(this);
  }
}

abstract class _DeliveryEvent implements DeliveryEvent {
  const factory _DeliveryEvent({
    required final DeliveryStatus status,
    required final DateTime at,
    required final double lat,
    required final double lng,
  }) = _$DeliveryEventImpl;

  factory _DeliveryEvent.fromJson(Map<String, dynamic> json) =
      _$DeliveryEventImpl.fromJson;

  @override
  DeliveryStatus get status;
  @override
  DateTime get at; // UTC
  @override
  double get lat;
  @override
  double get lng;

  /// Create a copy of DeliveryEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryEventImplCopyWith<_$DeliveryEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
