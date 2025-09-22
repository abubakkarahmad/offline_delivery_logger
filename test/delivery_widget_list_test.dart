import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_delivery_logger/data/datasources/local_db.dart';
import 'package:offline_delivery_logger/data/datasources/seed_data.dart';
import 'package:offline_delivery_logger/data/repositories/delivery_repository_impl.dart';
import 'package:offline_delivery_logger/data/repositories/sync_queue_repository_impl.dart';
import 'package:offline_delivery_logger/data/service/in_memory_api.dart';
import 'package:offline_delivery_logger/data/service/location_service.dart';
import 'package:offline_delivery_logger/data/service/offline_service.dart';
import 'package:offline_delivery_logger/presentation/controllers/delivery_list_controller.dart';
import 'package:offline_delivery_logger/presentation/controllers/export_controller.dart';
import 'package:offline_delivery_logger/presentation/controllers/offline_controller.dart';
import 'package:offline_delivery_logger/presentation/screens/deliveries_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();

  testWidgets('List updates after state changes', (tester) async {
    final db = await LocalDb.open(inMemory: true);
    await SeedData.ensureSeeded(db);
    final offline = OfflineService();
    final repo = DeliveryRepositoryImpl(
      db: db,
      offlineService: offline,
      api: InMemoryApi(),
      locationService: LocationService(seed: 123),
    );
    final syncRepo = SyncQueueRepositoryImpl(db: db, api: InMemoryApi());

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => OfflineController(
              offlineService: offline,
              syncRepo: syncRepo,
              deliveryRepo: repo,
            ),
          ),
          ChangeNotifierProvider(
            create: (_) =>
                DeliveryListController(deliveryRepo: repo, syncRepo: syncRepo),
          ),
          ChangeNotifierProvider(
            create: (_) => ExportController(deliveryRepo: repo),
          ),
        ],
        child: const MaterialApp(home: DeliveriesListScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('DEL-'), findsWidgets);

    // Perform a start to change status
    await repo.startDelivery('DEL-1003');
    await tester.pumpAndSettle();

    // The list should still render and include the item
    expect(find.textContaining('DEL-1003'), findsOneWidget);
  });
}
