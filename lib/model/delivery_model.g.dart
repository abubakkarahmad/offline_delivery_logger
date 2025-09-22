// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryModel _$DeliveryModelFromJson(Map<String, dynamic> json) =>
    DeliveryModel(
      id: json['id'] as String,
      customer: json['customer'] as String,
      address: json['address'] as String,
      notes: json['notes'] as String?,
      status: json['status'] as String,
      events: (json['events'] as List<dynamic>)
          .map((e) => DeliveryEventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeliveryModelToJson(DeliveryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer,
      'address': instance.address,
      'notes': instance.notes,
      'status': instance.status,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };
