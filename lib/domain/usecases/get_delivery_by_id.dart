import '../entities/delivery.dart';
import '../repositories/delivery_repository.dart';

class GetDeliveryById {
  final DeliveryRepository repo;
  GetDeliveryById(this.repo);
  Future<Delivery?> call(String id) => repo.getById(id);
}
