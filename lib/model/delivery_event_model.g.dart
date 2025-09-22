// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryEventModel _$DeliveryEventModelFromJson(Map<String, dynamic> json) =>
    DeliveryEventModel(
      status: json['status'] as String,
      at: json['at'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$DeliveryEventModelToJson(DeliveryEventModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'at': instance.at,
      'lat': instance.lat,
      'lng': instance.lng,
    };
