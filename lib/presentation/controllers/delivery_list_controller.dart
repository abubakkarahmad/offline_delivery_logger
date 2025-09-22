import 'package:flutter/foundation.dart';
import 'package:offline_delivery_logger/domain/entities/delivery.dart';
import 'package:offline_delivery_logger/domain/repositories/delivery_repository.dart';
import 'package:offline_delivery_logger/domain/repositories/sync_queue_repository.dart';

class DeliveryListController extends ChangeNotifier {
  final DeliveryRepository deliveryRepo;
  final SyncQueueRepository syncRepo;

  List<Delivery> _deliveries = [];
  int _queued = 0;

  List<Delivery> get deliveries => _deliveries;
  int get queued => _queued;

  DeliveryListController({required this.deliveryRepo, required this.syncRepo}) {
    deliveryRepo.watchDeliveries().listen((items) {
      _deliveries = items;
      notifyListeners();
    });
    _refreshQueue();
  }

  Future<void> _refreshQueue() async {
    _queued = await syncRepo.count();
    notifyListeners();
  }

  Future<void> refresh() async {
    _deliveries = await deliveryRepo.getDeliveriesOnce();
    _queued = await syncRepo.count();
    notifyListeners();
  }
}
