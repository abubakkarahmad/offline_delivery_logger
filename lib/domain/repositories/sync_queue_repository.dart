import '../entities/delivery_event.dart';

abstract class SyncQueueRepository {
  Future<void> enqueueStart(String id, DeliveryEvent event);
  Future<void> enqueueComplete(String id, DeliveryEvent event);
  Future<int> count();
  Future<int> replayOutbox();
}
