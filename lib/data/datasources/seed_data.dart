import 'package:offline_delivery_logger/model/delivery_model.dart';
import 'delivery_dao.dart';
import 'local_db.dart';

class SeedData {
  static Future<void> ensureSeeded(LocalDb db) async {
    final dao = DeliveryDao(db);
    if (!await dao.isEmpty()) return;

    final samples = <DeliveryModel>[
      DeliveryModel(
        id: 'DEL-1001',
        customer: 'Alice Smith',
        address: '221B Baker Street, London',
        notes: 'Leave at reception',
        status: 'New',
        events: [],
      ),
      DeliveryModel(
        id: 'DEL-1002',
        customer: 'Bob Johnson',
        address: '10 Downing Street, London',
        status: 'New',
        events: [],
        notes: null,
      ),
      DeliveryModel(
        id: 'DEL-1003',
        customer: 'Charlie Rose',
        address: 'Buckingham Palace Rd, London',
        status: 'New',
        events: [],
        notes: null,
      ),
      DeliveryModel(
        id: 'DEL-1004',
        customer: 'Diana Prince',
        address: 'Trafalgar Square, London',
        status: 'New',
        events: [],
        notes: null,
      ),
      DeliveryModel(
        id: 'DEL-1005',
        customer: 'Ethan Hunt',
        address: 'King\'s Cross Station, London',
        status: 'New',
        events: [],
        notes: null,
      ),
      DeliveryModel(
        id: 'DEL-1006',
        customer: 'Fiona Gallagher',
        address: 'London Eye, London',
        status: 'New',
        events: [],
        notes: null,
      ),
    ];

    for (final d in samples) {
      await dao.insertOrReplaceDelivery(d);
    }
  }
}
