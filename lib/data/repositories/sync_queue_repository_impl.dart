import 'dart:convert';

import 'package:offline_delivery_logger/data/datasources/delivery_dao.dart';
import 'package:offline_delivery_logger/data/datasources/local_db.dart';
import 'package:offline_delivery_logger/data/datasources/outbox_dao.dart';
import 'package:offline_delivery_logger/data/service/in_memory_api.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_event.dart';
import 'package:offline_delivery_logger/domain/repositories/sync_queue_repository.dart';
import 'package:offline_delivery_logger/model/delivery_event_model.dart';
import 'package:offline_delivery_logger/model/outbox_item_model.dart';

class SyncQueueRepositoryImpl implements SyncQueueRepository {
  final LocalDb db;
  final InMemoryApi api;
  late final OutboxDao _outboxDao;
  late final DeliveryDao _deliveryDao;

  SyncQueueRepositoryImpl({required this.db, required this.api}) {
    _outboxDao = OutboxDao(db);
    _deliveryDao = DeliveryDao(db);
  }

  @override
  Future<void> enqueueStart(String id, DeliveryEvent event) async {
    // Enqueue handled inside DeliveryRepositoryImpl
  }

  @override
  Future<void> enqueueComplete(String id, DeliveryEvent event) async {
    // Enqueue handled inside DeliveryRepositoryImpl
  }

  @override
  Future<int> count() => _outboxDao.count();

  @override
  Future<int> replayOutbox() async {
    final items = await _outboxDao.all();
    var success = 0;
    for (final item in items) {
      try {
        final eventJson = _parseJson(item.payloadJson);
        final eventModel = DeliveryEventModel.fromJson(eventJson);
        // Ensure delivery exists remotely with baseline values
        final localDelivery = await _deliveryDao.getById(item.deliveryId);
        if (localDelivery != null) {
          await api.upsertDelivery(localDelivery);
        }
        if (item.type == OutboxType.start) {
          await api.applyStart(item.deliveryId, eventModel);
        } else {
          await api.applyComplete(item.deliveryId, eventModel);
        }
        await _outboxDao.remove(item.id);
        success++;
      } catch (_) {
        await _outboxDao.incrementAttempts(item.id);
      }
    }
    return success;
  }

  Map<String, dynamic> _parseJson(String s) {
    // payloadJson was saved with Map.toString(); try to fix single quotes
    if (s.contains("'")) {
      s = s.replaceAll("'", '"');
    }
    return jsonDecode(s) as Map<String, dynamic>;
  }
}
