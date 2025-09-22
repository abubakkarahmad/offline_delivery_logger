import 'package:flutter/material.dart';
import 'package:offline_delivery_logger/domain/entities/delivery.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_event.dart';
import 'package:offline_delivery_logger/domain/entities/delivery_status.dart';
import 'package:offline_delivery_logger/presentation/controllers/delivery_details_controller.dart';
import 'package:offline_delivery_logger/presentation/widgets/custom_buttons.dart'
    show CustomButton;
import 'package:offline_delivery_logger/presentation/widgets/custom_text.dart';
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
        centerTitle: true,
        title: const CustomText(
          text: "Delivery",
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CustomText(
              text: d.customer,
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            CustomText(text: d.id, color: Colors.black, fontSize: 12),
            const SizedBox(height: 20),
            CustomText(
              text: d.address,
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            d.notes != null
                ? CustomText(
                    text: "Notes: ${d.notes!}",
                    color: Colors.black,
                    fontSize: 12,
                  )
                : const CustomText(
                    text: "Notes: ${""}",
                    color: Colors.black,
                    fontSize: 12,
                  ),
            Row(
              children: [
                const CustomText(
                  text: "Status:",
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),

                const SizedBox(width: 4),
                CustomText(
                  text: d.status.name,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const CustomText(
              text: "Events",
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            if (d.events.isEmpty)
              const CustomText(
                text: "No events yet",
                color: Colors.black,
                fontSize: 12,
              )
            else
              ...d.events.map((e) => _eventTile(e)),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canStart)
              CustomButton(
                title: "Start Delivery",
                subtitle: "Begin this delivery process",
                icon: Icons.play_arrow,
                onTap: () => _handleStart(context),
              ),
            if (canComplete)
              CustomButton(
                title: "Complete",
                subtitle: "Mark this delivery as completed",
                icon: Icons.check_circle,
                onTap: () => _handleComplete(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _eventTile(DeliveryEvent e) {
    return Card(
      color: Colors.white24,
      child: ListTile(
        title: CustomText(
          text: e.status.name,
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        subtitle: Text(
          '${e.at.toUtc()}\n(${e.lat.toStringAsFixed(4)}, ${e.lng.toStringAsFixed(4)})',
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
