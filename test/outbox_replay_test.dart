import 'package:flutter_test/flutter_test.dart';
import 'package:offline_delivery_logger/data/datasources/local_db.dart';
import 'package:offline_delivery_logger/data/datasources/seed_data.dart';
import 'package:offline_delivery_logger/data/repositories/delivery_repository_impl.dart';
import 'package:offline_delivery_logger/data/service/in_memory_api.dart';
import 'package:offline_delivery_logger/data/service/location_service.dart';
import 'package:offline_delivery_logger/data/service/offline_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();

  test('Start -> Complete updates status and events', () async {
    final db = await LocalDb.open(inMemory: true);
    await SeedData.ensureSeeded(db);
    final repo = DeliveryRepositoryImpl(
      db: db,
      offlineService: OfflineService(),
      api: InMemoryApi(),
      locationService: LocationService(seed: 42),
    );

    final id = 'DEL-1001';
    var d = await repo.getById(id);
    expect(d?.status.name, 'New');
    await repo.startDelivery(id);
    d = await repo.getById(id);
    expect(d?.status.name, 'InProgress');
    expect(d?.events.length, 1);

    await repo.completeDelivery(id);
    d = await repo.getById(id);
    expect(d?.status.name, 'Completed');
    expect(d?.events.length, 2);
  });
}
