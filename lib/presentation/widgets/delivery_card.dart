import 'package:flutter/material.dart';
import 'package:offline_delivery_logger/presentation/widgets/custom_text.dart';
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
      color: Colors.white24,
      child: ListTile(
        onTap: onTap,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: delivery.customer,
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            CustomText(text: delivery.id, fontSize: 12, color: Colors.black),
          ],
        ),
        subtitle: CustomText(
          text: delivery.address,
          fontSize: 12,
          color: Colors.black,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: statusColor),
          ),
          child: CustomText(
            text: delivery.status.name,
            fontSize: 12,
            color: Colors.black38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
