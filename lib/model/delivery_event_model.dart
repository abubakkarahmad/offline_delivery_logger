import 'package:json_annotation/json_annotation.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_event.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_status.dart';

part 'delivery_event_model.g.dart';

@JsonSerializable()
class DeliveryEventModel {
  final String status;
  final String at; // ISO UTC
  final double lat;
  final double lng;

  DeliveryEventModel({
    required this.status,
    required this.at,
    required this.lat,
    required this.lng,
  });

  factory DeliveryEventModel.fromDomain(DeliveryEvent e) => DeliveryEventModel(
    status: e.status.asString,
    at: e.at.toUtc().toIso8601String(),
    lat: e.lat,
    lng: e.lng,
  );

  DeliveryEvent toDomain() => DeliveryEvent(
    status: DeliveryStatus.fromString(status),
    at: DateTime.parse(at).toUtc(),
    lat: lat,
    lng: lng,
  );

  factory DeliveryEventModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryEventModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryEventModelToJson(this);
}
