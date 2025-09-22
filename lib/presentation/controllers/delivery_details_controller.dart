import 'package:offline_delivery_logger/domain/entities/delivery.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_status.dart';
import 'package:offline_delivery_logger/domain/repositories/delivery_repository.dart';

class DeliveryDetailController {
  final DeliveryRepository deliveryRepo;
  DeliveryDetailController({required this.deliveryRepo});

  Future<Delivery?> getById(String id) => deliveryRepo.getById(id);

  Future<String?> start(String id) async {
    final d = await deliveryRepo.getById(id);
    if (d == null) return 'Delivery not found';
    if (d.status == DeliveryStatus.inProgress ||
        d.status == DeliveryStatus.completed) {
      return 'Cannot start: already ${d.status.asString}';
    }
    await deliveryRepo.startDelivery(id);
    return null;
  }

  Future<String?> complete(String id) async {
    final d = await deliveryRepo.getById(id);
    if (d == null) return 'Delivery not found';
    if (d.status.asString != 'InProgress') {
      return 'Cannot complete: must be InProgress';
    }
    await deliveryRepo.completeDelivery(id);
    return null;
  }
}
