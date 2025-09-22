// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbox_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutboxItemModel _$OutboxItemModelFromJson(Map<String, dynamic> json) =>
    OutboxItemModel(
      id: json['id'] as String,
      type: $enumDecode(_$OutboxTypeEnumMap, json['type']),
      deliveryId: json['deliveryId'] as String,
      payloadJson: json['payloadJson'] as String,
      attempts: (json['attempts'] as num).toInt(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$OutboxItemModelToJson(OutboxItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$OutboxTypeEnumMap[instance.type]!,
      'deliveryId': instance.deliveryId,
      'payloadJson': instance.payloadJson,
      'attempts': instance.attempts,
      'createdAt': instance.createdAt,
    };

const _$OutboxTypeEnumMap = {
  OutboxType.start: 'start',
  OutboxType.complete: 'complete',
};
