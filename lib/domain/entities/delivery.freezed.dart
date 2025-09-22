// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Delivery _$DeliveryFromJson(Map<String, dynamic> json) {
  return _Delivery.fromJson(json);
}

/// @nodoc
mixin _$Delivery {
  String get id => throw _privateConstructorUsedError;
  String get customer => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DeliveryStatus get status => throw _privateConstructorUsedError;
  List<DeliveryEvent> get events => throw _privateConstructorUsedError;

  /// Serializes this Delivery to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryCopyWith<Delivery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryCopyWith<$Res> {
  factory $DeliveryCopyWith(Delivery value, $Res Function(Delivery) then) =
      _$DeliveryCopyWithImpl<$Res, Delivery>;
  @useResult
  $Res call({
    String id,
    String customer,
    String address,
    String? notes,
    DeliveryStatus status,
    List<DeliveryEvent> events,
  });
}

/// @nodoc
class _$DeliveryCopyWithImpl<$Res, $Val extends Delivery>
    implements $DeliveryCopyWith<$Res> {
  _$DeliveryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customer = null,
    Object? address = null,
    Object? notes = freezed,
    Object? status = null,
    Object? events = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            customer: null == customer
                ? _value.customer
                : customer // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DeliveryStatus,
            events: null == events
                ? _value.events
                : events // ignore: cast_nullable_to_non_nullable
                      as List<DeliveryEvent>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeliveryImplCopyWith<$Res>
    implements $DeliveryCopyWith<$Res> {
  factory _$$DeliveryImplCopyWith(
    _$DeliveryImpl value,
    $Res Function(_$DeliveryImpl) then,
  ) = __$$DeliveryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String customer,
    String address,
    String? notes,
    DeliveryStatus status,
    List<DeliveryEvent> events,
  });
}

/// @nodoc
class __$$DeliveryImplCopyWithImpl<$Res>
    extends _$DeliveryCopyWithImpl<$Res, _$DeliveryImpl>
    implements _$$DeliveryImplCopyWith<$Res> {
  __$$DeliveryImplCopyWithImpl(
    _$DeliveryImpl _value,
    $Res Function(_$DeliveryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customer = null,
    Object? address = null,
    Object? notes = freezed,
    Object? status = null,
    Object? events = null,
  }) {
    return _then(
      _$DeliveryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        customer: null == customer
            ? _value.customer
            : customer // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DeliveryStatus,
        events: null == events
            ? _value._events
            : events // ignore: cast_nullable_to_non_nullable
                  as List<DeliveryEvent>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryImpl implements _Delivery {
  const _$DeliveryImpl({
    required this.id,
    required this.customer,
    required this.address,
    this.notes,
    required this.status,
    final List<DeliveryEvent> events = const <DeliveryEvent>[],
  }) : _events = events;

  factory _$DeliveryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryImplFromJson(json);

  @override
  final String id;
  @override
  final String customer;
  @override
  final String address;
  @override
  final String? notes;
  @override
  final DeliveryStatus status;
  final List<DeliveryEvent> _events;
  @override
  @JsonKey()
  List<DeliveryEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'Delivery(id: $id, customer: $customer, address: $address, notes: $notes, status: $status, events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    customer,
    address,
    notes,
    status,
    const DeepCollectionEquality().hash(_events),
  );

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryImplCopyWith<_$DeliveryImpl> get copyWith =>
      __$$DeliveryImplCopyWithImpl<_$DeliveryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryImplToJson(this);
  }
}

abstract class _Delivery implements Delivery {
  const factory _Delivery({
    required final String id,
    required final String customer,
    required final String address,
    final String? notes,
    required final DeliveryStatus status,
    final List<DeliveryEvent> events,
  }) = _$DeliveryImpl;

  factory _Delivery.fromJson(Map<String, dynamic> json) =
      _$DeliveryImpl.fromJson;

  @override
  String get id;
  @override
  String get customer;
  @override
  String get address;
  @override
  String? get notes;
  @override
  DeliveryStatus get status;
  @override
  List<DeliveryEvent> get events;

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryImplCopyWith<_$DeliveryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
