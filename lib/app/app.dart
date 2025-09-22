import 'package:flutter/material.dart';
import 'package:offline_delivery_logger/app/router.dart';
import 'package:offline_delivery_logger/data/datasources/local_db.dart';
import 'package:offline_delivery_logger/data/datasources/seed_data.dart';
import 'package:offline_delivery_logger/data/repositories/delivery_repository_impl.dart';
import 'package:offline_delivery_logger/data/repositories/sync_queue_repository_impl.dart';
import 'package:offline_delivery_logger/data/service/in_memory_api.dart';
import 'package:offline_delivery_logger/data/service/location_service.dart';
import 'package:offline_delivery_logger/data/service/offline_service.dart';
import 'package:offline_delivery_logger/presentation/controllers/delivery_details_controller.dart';
import 'package:offline_delivery_logger/presentation/controllers/delivery_list_controller.dart';
import 'package:offline_delivery_logger/presentation/controllers/export_controller.dart';
import 'package:offline_delivery_logger/presentation/controllers/offline_controller.dart';
import 'package:offline_delivery_logger/presentation/screens/deliveries_list_screen.dart';
import 'package:provider/provider.dart';

class OfflineDeliveryLoggerApp extends StatefulWidget {
  const OfflineDeliveryLoggerApp({super.key});

  @override
  State<OfflineDeliveryLoggerApp> createState() =>
      _OfflineDeliveryLoggerAppState();
}

class _OfflineDeliveryLoggerAppState extends State<OfflineDeliveryLoggerApp> {
  final offlineService = OfflineService();
  late final InMemoryApi api;
  late final LocationService locationService;

  @override
  void initState() {
    super.initState();
    api = InMemoryApi();
    locationService = LocationService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _bootstrap(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        final db = snapshot.data as LocalDb;
        final deliveryRepo = DeliveryRepositoryImpl(
          db: db,
          offlineService: offlineService,
          api: api,
          locationService: locationService,
        );
        final syncRepo = SyncQueueRepositoryImpl(db: db, api: api);

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => OfflineController(
                offlineService: offlineService,
                syncRepo: syncRepo,
                deliveryRepo: deliveryRepo,
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => DeliveryListController(
                deliveryRepo: deliveryRepo,
                syncRepo: syncRepo,
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => ExportController(deliveryRepo: deliveryRepo),
            ),
            Provider<DeliveryDetailController>(
              create: (_) =>
                  DeliveryDetailController(deliveryRepo: deliveryRepo),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Offline Delivery Logger',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
              useMaterial3: true,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: DeliveriesListScreen.routeName,
          ),
        );
      },
    );
  }

  Future<LocalDb> _bootstrap() async {
    final db = await LocalDb.open();
    await SeedData.ensureSeeded(db);
    return db;
  }
}
