import 'package:offline_delivery_logger/model/delivery_event_model.dart';
import 'package:offline_delivery_logger/model/delivery_model.dart';
import 'package:sqflite/sqflite.dart';
import 'local_db.dart';

class DeliveryDao {
  final LocalDb localDb;
  DeliveryDao(this.localDb);

  Future<void> insertOrReplaceDelivery(DeliveryModel model) async {
    await localDb.db.insert('deliveries', {
      'id': model.id,
      'customer': model.customer,
      'address': model.address,
      'notes': model.notes,
      'status': model.status,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateStatus(String id, String status) async {
    await localDb.db.update(
      'deliveries',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertEvent(String deliveryId, DeliveryEventModel event) async {
    await localDb.db.insert('delivery_events', {
      'delivery_id': deliveryId,
      'status': event.status,
      'at': event.at,
      'lat': event.lat,
      'lng': event.lng,
    });
  }

  Future<List<DeliveryModel>> getAll() async {
    final deliveriesRows = await localDb.db.query(
      'deliveries',
      orderBy: 'id ASC',
    );
    final deliveries = <DeliveryModel>[];
    for (final row in deliveriesRows) {
      final eventsRows = await localDb.db.query(
        'delivery_events',
        where: 'delivery_id = ?',
        whereArgs: [row['id']],
        orderBy: 'at ASC',
      );
      final events = eventsRows
          .map(
            (e) => DeliveryEventModel(
              status: e['status'] as String,
              at: e['at'] as String,
              lat: e['lat'] as double,
              lng: e['lng'] as double,
            ),
          )
          .toList();
      deliveries.add(
        DeliveryModel(
          id: row['id'] as String,
          customer: row['customer'] as String,
          address: row['address'] as String,
          notes: row['notes'] as String?,
          status: row['status'] as String,
          events: events,
        ),
      );
    }
    return deliveries;
  }

  Future<DeliveryModel?> getById(String id) async {
    final rows = await localDb.db.query(
      'deliveries',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    final eventsRows = await localDb.db.query(
      'delivery_events',
      where: 'delivery_id = ?',
      whereArgs: [id],
      orderBy: 'at ASC',
    );
    final events = eventsRows
        .map(
          (e) => DeliveryEventModel(
            status: e['status'] as String,
            at: e['at'] as String,
            lat: e['lat'] as double,
            lng: e['lng'] as double,
          ),
        )
        .toList();
    return DeliveryModel(
      id: row['id'] as String,
      customer: row['customer'] as String,
      address: row['address'] as String,
      notes: row['notes'] as String?,
      status: row['status'] as String,
      events: events,
    );
  }

  Future<List<DeliveryModel>> getCompleted() async {
    final rows = await localDb.db.query(
      'deliveries',
      where: 'status = ?',
      whereArgs: ['Completed'],
      orderBy: 'id ASC',
    );
    final list = <DeliveryModel>[];
    for (final row in rows) {
      final eventsRows = await localDb.db.query(
        'delivery_events',
        where: 'delivery_id = ?',
        whereArgs: [row['id']],
        orderBy: 'at ASC',
      );
      final events = eventsRows
          .map(
            (e) => DeliveryEventModel(
              status: e['status'] as String,
              at: e['at'] as String,
              lat: e['lat'] as double,
              lng: e['lng'] as double,
            ),
          )
          .toList();
      list.add(
        DeliveryModel(
          id: row['id'] as String,
          customer: row['customer'] as String,
          address: row['address'] as String,
          notes: row['notes'] as String?,
          status: row['status'] as String,
          events: events,
        ),
      );
    }
    return list;
  }

  Future<bool> isEmpty() async {
    final c =
        Sqflite.firstIntValue(
          await localDb.db.rawQuery('SELECT COUNT(*) FROM deliveries'),
        ) ??
        0;
    return c == 0;
  }
}
