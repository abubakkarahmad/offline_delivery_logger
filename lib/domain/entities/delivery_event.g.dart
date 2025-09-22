// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeliveryEventImpl _$$DeliveryEventImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryEventImpl(
      status: $enumDecode(_$DeliveryStatusEnumMap, json['status']),
      at: DateTime.parse(json['at'] as String),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$$DeliveryEventImplToJson(_$DeliveryEventImpl instance) =>
    <String, dynamic>{
      'status': _$DeliveryStatusEnumMap[instance.status]!,
      'at': instance.at.toIso8601String(),
      'lat': instance.lat,
      'lng': instance.lng,
    };

const _$DeliveryStatusEnumMap = {
  DeliveryStatus.initial: 'initial',
  DeliveryStatus.inProgress: 'inProgress',
  DeliveryStatus.completed: 'completed',
};
