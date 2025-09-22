import 'package:offline_delivery_logger/domain/entities/delivery.dart';

abstract class DeliveryRepository {
  Stream<List<Delivery>> watchDeliveries();
  Future<List<Delivery>> getDeliveriesOnce();
  Future<Delivery?> getById(String id);
  Future<void> startDelivery(String id);
  Future<void> completeDelivery(String id);
  Future<List<Delivery>> getCompleted();
  Future<int> getQueuedCount();
}
