import '../repositories/delivery_repository.dart';

class CompleteDelivery {
  final DeliveryRepository repo;
  CompleteDelivery(this.repo);
  Future<void> call(String id) => repo.completeDelivery(id);
}
