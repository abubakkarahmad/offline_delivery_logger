import 'package:freezed_annotation/freezed_annotation.dart';
import 'delivery_status.dart';

part 'delivery_event.freezed.dart';
part 'delivery_event.g.dart';

@freezed
class DeliveryEvent with _$DeliveryEvent {
  const factory DeliveryEvent({
    required DeliveryStatus status,
    required DateTime at, // UTC
    required double lat,
    required double lng,
  }) = _DeliveryEvent;

  factory DeliveryEvent.fromJson(Map<String, dynamic> json) =>
      _$DeliveryEventFromJson(json);
}
