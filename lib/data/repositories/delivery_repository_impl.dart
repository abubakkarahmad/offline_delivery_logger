import 'dart:async';
import 'package:offline_delivery_logger/data/service/in_memory_api.dart';
import 'package:offline_delivery_logger/data/service/location_service.dart';
import 'package:offline_delivery_logger/data/service/offline_service.dart';
import 'package:offline_delivery_logger/model/delivery_event_model.dart';
import 'package:offline_delivery_logger/model/outbox_item_model.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/delivery.dart';
import '../../domain/entities/delivery_event.dart';
import '../../domain/entities/delivery_status.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../datasources/delivery_dao.dart';
import '../datasources/local_db.dart';
import '../datasources/outbox_dao.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  final LocalDb db;
  final OfflineService offlineService;
  final InMemoryApi api;
  final LocationService locationService;

  final _controller = StreamController<List<Delivery>>.broadcast();

  late final DeliveryDao _deliveryDao;
  late final OutboxDao _outboxDao;

  DeliveryRepositoryImpl({
    required this.db,
    required this.offlineService,
    required this.api,
    required this.locationService,
  }) {
    _deliveryDao = DeliveryDao(db);
    _outboxDao = OutboxDao(db);
    _refresh();
  }

  @override
  Stream<List<Delivery>> watchDeliveries() => _controller.stream;

  @override
  Future<List<Delivery>> getDeliveriesOnce() async {
    final models = await _deliveryDao.getAll();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<Delivery?> getById(String id) async {
    final model = await _deliveryDao.getById(id);
    return model?.toDomain();
  }

  @override
  Future<void> startDelivery(String id) async {
    final now = DateTime.now().toUtc();
    final loc = locationService.randomLondon();
    final event = DeliveryEvent(
      status: DeliveryStatus.inProgress,
      at: now,
      lat: loc.lat,
      lng: loc.lng,
    );
    await _applyLocalAndMaybeEnqueue(id, event, OutboxType.start);
  }

  @override
  Future<void> completeDelivery(String id) async {
    final now = DateTime.now().toUtc();
    final loc = locationService.randomLondon();
    final event = DeliveryEvent(
      status: DeliveryStatus.completed,
      at: now,
      lat: loc.lat,
      lng: loc.lng,
    );
    await _applyLocalAndMaybeEnqueue(id, event, OutboxType.complete);
  }

  Future<void> _applyLocalAndMaybeEnqueue(
    String id,
    DeliveryEvent event,
    OutboxType type,
  ) async {
    final model = await _deliveryDao.getById(id);
    if (model == null) return;

    if (type == OutboxType.start && model.status != 'New') {
      // Ignore invalid transition; UI shows snackbar elsewhere.
      return;
    }
    if (type == OutboxType.complete && model.status != 'InProgress') {
      return;
    }

    final eventModel = DeliveryEventModel.fromDomain(event);
    await _deliveryDao.insertEvent(id, eventModel);
    final newStatus = type == OutboxType.start ? 'InProgress' : 'Completed';
    await _deliveryDao.updateStatus(id, newStatus);

    // Emit updated list
    await _refresh();

    if (offlineService.isOffline.value) {
      // enqueue
      final outbox = OutboxDao(db);
      final item = OutboxItemModel(
        id: const Uuid().v4(),
        type: type,
        deliveryId: id,
        payloadJson: eventModel.toJson().toString(),
        attempts: 0,
        createdAt: nowIso(),
      );
      await outbox.enqueue(item);
    } else {
      // Also send to API
      await api.upsertDelivery(model);
      if (type == OutboxType.start) {
        await api.applyStart(id, eventModel);
      } else {
        await api.applyComplete(id, eventModel);
      }
    }
  }

  String nowIso() => DateTime.now().toUtc().toIso8601String();

  Future<void> _refresh() async {
    final list = await _deliveryDao.getAll();
    _controller.add(list.map((e) => e.toDomain()).toList());
  }

  @override
  Future<List<Delivery>> getCompleted() async {
    final list = await _deliveryDao.getCompleted();
    return list.map((e) => e.toDomain()).toList();
  }

  @override
  Future<int> getQueuedCount() => _outboxDao.count();
}
