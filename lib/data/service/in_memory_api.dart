import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:offline_delivery_logger/model/delivery_event_model.dart';
import 'package:offline_delivery_logger/model/delivery_model.dart';

class InMemoryApi {
  final Map<String, DeliveryModel> _store = {};

  Future<void> upsertDelivery(DeliveryModel model) async {
    _store[model.id] = model;
  }

  Future<void> applyStart(String deliveryId, DeliveryEventModel event) async {
    if (kDebugMode) {
      print(
        '[API] Start delivery $deliveryId at ${event.at} (${event.lat}, ${event.lng})',
      );
    }
    _ensure(deliveryId);
    final current = _store[deliveryId]!;
    final updated = current.copyWith(
      status: 'InProgress',
      events: [...current.events, event],
    );
    _store[deliveryId] = updated;
  }

  Future<void> applyComplete(
    String deliveryId,
    DeliveryEventModel event,
  ) async {
    if (kDebugMode) {
      print(
        '[API] Complete delivery $deliveryId at ${event.at} (${event.lat}, ${event.lng})',
      );
    }
    _ensure(deliveryId);
    final current = _store[deliveryId]!;
    final updated = current.copyWith(
      status: 'Completed',
      events: [...current.events, event],
    );
    _store[deliveryId] = updated;
  }

  void _ensure(String id) {
    _store.putIfAbsent(
      id,
      () => DeliveryModel(
        id: id,
        customer: 'Unknown',
        address: 'Unknown',
        status: 'New',
        events: [],
      ),
    );
  }

  String dumpJson() =>
      jsonEncode(_store.map((k, v) => MapEntry(k, v.toJson())));
}
