import '../repositories/delivery_repository.dart';

class StartDelivery {
  final DeliveryRepository repo;
  StartDelivery(this.repo);
  Future<void> call(String id) => repo.startDelivery(id);
}
