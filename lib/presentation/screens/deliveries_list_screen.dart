import 'package:flutter/material.dart';
import 'package:offline_delivery_logger/presentation/controllers/delivery_list_controller.dart';
import 'package:offline_delivery_logger/presentation/controllers/export_controller.dart';
import 'package:offline_delivery_logger/presentation/controllers/offline_controller.dart';
import 'package:offline_delivery_logger/presentation/screens/delivery_detail_screen.dart';
import 'package:offline_delivery_logger/presentation/widgets/delivery_card.dart';
import 'package:provider/provider.dart';

class DeliveriesListScreen extends StatelessWidget {
  static const routeName = '/';
  const DeliveriesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offline = context.watch<OfflineController>();
    final list = context.watch<DeliveryListController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deliveries'),
        actions: [
          Row(
            children: [
              Icon(
                offline.isOffline ? Icons.cloud_off : Icons.cloud_done,
                color: offline.isOffline ? Colors.orange : Colors.green,
              ),
              const SizedBox(width: 4),
              Text(offline.isOffline ? 'Offline' : 'Online'),
              const SizedBox(width: 8),
              if (list.queued > 0 || offline.queued > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Queued: ${offline.queued}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(width: 12),
              Switch(
                value: offline.isOffline,
                onChanged: (_) => offline.toggle(context),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final export = context.read<ExportController>();
          try {
            await export.sharePdf();
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
            }
          }
        },
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text('Completed Report'),
      ),
      body: RefreshIndicator(
        onRefresh: () => list.refresh(),
        child: Builder(
          builder: (context) {
            final deliveries = list.deliveries;
            if (deliveries.isEmpty) {
              return const ListTile(title: Text('No deliveries'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: deliveries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final d = deliveries[index];
                return DeliveryCard(
                  delivery: d,
                  onTap: () => Navigator.pushNamed(
                    context,
                    DeliveryDetailScreen.routeName,
                    arguments: d.id,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
