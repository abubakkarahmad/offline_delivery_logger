import 'package:offline_delivery_logger/model/outbox_item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'local_db.dart';

class OutboxDao {
  final LocalDb localDb;
  OutboxDao(this.localDb);

  Future<void> enqueue(OutboxItemModel item) async {
    await localDb.db.insert('outbox', {
      'id': item.id,
      'type': item.type.name,
      'delivery_id': item.deliveryId,
      'payload_json': item.payloadJson,
      'attempts': item.attempts,
      'created_at': item.createdAt,
    });
  }

  Future<List<OutboxItemModel>> all() async {
    final rows = await localDb.db.query('outbox', orderBy: 'created_at ASC');
    return rows
        .map(
          (r) => OutboxItemModel(
            id: r['id'] as String,
            type: (r['type'] as String) == 'start'
                ? OutboxType.start
                : OutboxType.complete,
            deliveryId: r['delivery_id'] as String,
            payloadJson: r['payload_json'] as String,
            attempts: r['attempts'] as int,
            createdAt: r['created_at'] as String,
          ),
        )
        .toList();
  }

  Future<int> count() async {
    final c =
        Sqflite.firstIntValue(
          await localDb.db.rawQuery('SELECT COUNT(*) FROM outbox'),
        ) ??
        0;
    return c;
  }

  Future<void> incrementAttempts(String id) async {
    await localDb.db.rawUpdate(
      'UPDATE outbox SET attempts = attempts + 1 WHERE id = ?',
      [id],
    );
  }

  Future<void> remove(String id) async {
    await localDb.db.delete('outbox', where: 'id = ?', whereArgs: [id]);
  }

  // For tests
  Future<void> clear() async {
    await localDb.db.delete('outbox');
  }
}
