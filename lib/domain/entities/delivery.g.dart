// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeliveryImpl _$$DeliveryImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryImpl(
      id: json['id'] as String,
      customer: json['customer'] as String,
      address: json['address'] as String,
      notes: json['notes'] as String?,
      status: $enumDecode(_$DeliveryStatusEnumMap, json['status']),
      events:
          (json['events'] as List<dynamic>?)
              ?.map((e) => DeliveryEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DeliveryEvent>[],
    );

Map<String, dynamic> _$$DeliveryImplToJson(_$DeliveryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer,
      'address': instance.address,
      'notes': instance.notes,
      'status': _$DeliveryStatusEnumMap[instance.status]!,
      'events': instance.events,
    };

const _$DeliveryStatusEnumMap = {
  DeliveryStatus.initial: 'initial',
  DeliveryStatus.inProgress: 'inProgress',
  DeliveryStatus.completed: 'completed',
};
