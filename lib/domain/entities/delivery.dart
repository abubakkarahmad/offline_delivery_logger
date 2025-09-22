import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_event.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_status.dart';

part 'delivery.freezed.dart';
part 'delivery.g.dart';

@freezed
class Delivery with _$Delivery {
  const factory Delivery({
    required String id,
    required String customer,
    required String address,
    String? notes,
    required DeliveryStatus status,
    @Default(<DeliveryEvent>[]) List<DeliveryEvent> events,
  }) = _Delivery;

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);
}
