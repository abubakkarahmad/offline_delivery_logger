import 'package:flutter/material.dart';
import '../../domain/entities/delivery.dart';

class DeliveryCard extends StatelessWidget {
  final Delivery delivery;
  final VoidCallback onTap;

  const DeliveryCard({super.key, required this.delivery, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (delivery.status.name) {
      'New' => Colors.blue,
      'InProgress' => Colors.orange,
      'Completed' => Colors.green,
      _ => Colors.grey,
    };

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text('${delivery.id} • ${delivery.customer}'),
        subtitle: Text(delivery.address),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor),
          ),
          child: Text(
            delivery.status.name,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
