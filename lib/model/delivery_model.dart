import 'package:json_annotation/json_annotation.dart';
import 'package:offline_delivery_logger/domain/entities/delivery.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_status.dart';
import 'package:offline_delivery_logger/model/delivery_event_model.dart';

part 'delivery_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeliveryModel {
  final String id;
  final String customer;
  final String address;
  final String? notes;
  final String status;
  final List<DeliveryEventModel> events;

  DeliveryModel({
    required this.id,
    required this.customer,
    required this.address,
    this.notes,
    required this.status,
    required this.events,
  });

  factory DeliveryModel.fromDomain(Delivery d) => DeliveryModel(
    id: d.id,
    customer: d.customer,
    address: d.address,
    notes: d.notes,
    status: d.status.asString,
    events: d.events.map(DeliveryEventModel.fromDomain).toList(),
  );

  Delivery toDomain() => Delivery(
    id: id,
    customer: customer,
    address: address,
    notes: notes,
    status: DeliveryStatus.fromString(status),
    events: events.map((e) => e.toDomain()).toList(),
  );

  factory DeliveryModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryModelToJson(this);

  DeliveryModel copyWith({
    String? id,
    String? customer,
    String? address,
    String? notes,
    String? status,
    List<DeliveryEventModel>? events,
  }) {
    return DeliveryModel(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      events: events ?? this.events,
    );
  }
}
