import '../entities/delivery.dart';
import '../repositories/delivery_repository.dart';

class GetDeliveries {
  final DeliveryRepository repo;
  GetDeliveries(this.repo);
  Stream<List<Delivery>> call() => repo.watchDeliveries();
}
