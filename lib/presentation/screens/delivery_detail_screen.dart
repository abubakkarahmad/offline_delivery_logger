import 'package:flutter/material.dart';
import 'package:offline_delivery_logger/domain/entities/delivery.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_event.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_status.dart';
import 'package:offline_delivery_logger/presentation/controllers/delivery_details_controller.dart';
import 'package:provider/provider.dart';

class DeliveryDetailScreen extends StatefulWidget {
  static const routeName = '/detail';
  final String deliveryId;
  const DeliveryDetailScreen({super.key, required this.deliveryId});

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  Delivery? _delivery;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ctrl = context.read<DeliveryDetailController>();
    final d = await ctrl.getById(widget.deliveryId);
    setState(() => _delivery = d);
  }

  @override
  Widget build(BuildContext context) {
    final d = _delivery;
    if (d == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final canStart = d.status == DeliveryStatus.initial;
    final canComplete = d.status == DeliveryStatus.inProgress;

    return Scaffold(
      appBar: AppBar(
        title: Text('${d.id} - ${d.customer}'),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(d.address, style: Theme.of(context).textTheme.titleMedium),
            if (d.notes != null)
              Text(
                'Notes: ${d.notes!}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(d.status.name),
              ],
            ),
            const SizedBox(height: 24),
            Text('Events', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (d.events.isEmpty)
              const Text('No events yet.')
            else
              ...d.events.map((e) => _eventTile(e)),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: canStart ? () => _handleStart(context) : null,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Delivery'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: canComplete
                      ? () => _handleComplete(context)
                      : null,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Complete'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _eventTile(DeliveryEvent e) {
    return Card(
      child: ListTile(
        title: Text(e.status.name),
        subtitle: Text(
          '${e.at.toUtc()}  •  (${e.lat.toStringAsFixed(4)}, ${e.lng.toStringAsFixed(4)})',
        ),
      ),
    );
  }

  Future<void> _handleStart(BuildContext context) async {
    final ctrl = context.read<DeliveryDetailController>();
    final error = await ctrl.start(widget.deliveryId);
    if (error != null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      }
    } else {
      await _reload(context);
    }
  }

  Future<void> _handleComplete(BuildContext context) async {
    final ctrl = context.read<DeliveryDetailController>();
    final error = await ctrl.complete(widget.deliveryId);
    if (error != null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      }
    } else {
      await _reload(context);
    }
  }

  Future<void> _reload(BuildContext context) async {
    final d = await context.read<DeliveryDetailController>().getById(
      widget.deliveryId,
    );
    setState(() => _delivery = d);
  }
}
