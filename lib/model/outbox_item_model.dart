import 'package:json_annotation/json_annotation.dart';

part 'outbox_item_model.g.dart';

enum OutboxType { start, complete }

@JsonSerializable()
class OutboxItemModel {
  final String id; // uuid
  final OutboxType type;
  final String deliveryId;
  final String payloadJson; // serialized DeliveryEventModel
  final int attempts;
  final String createdAt; // ISO

  OutboxItemModel({
    required this.id,
    required this.type,
    required this.deliveryId,
    required this.payloadJson,
    required this.attempts,
    required this.createdAt,
  });

  factory OutboxItemModel.fromJson(Map<String, dynamic> json) =>
      _$OutboxItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OutboxItemModelToJson(this);

  OutboxItemModel copyWith({int? attempts}) => OutboxItemModel(
    id: id,
    type: type,
    deliveryId: deliveryId,
    payloadJson: payloadJson,
    attempts: attempts ?? this.attempts,
    createdAt: createdAt,
  );
}
