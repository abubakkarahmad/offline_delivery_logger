import 'package:flutter/material.dart';
import 'package:offline_delivery_logger/presentation/screens/deliveries_list_screen.dart';
import 'package:offline_delivery_logger/presentation/screens/delivery_detail_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DeliveriesListScreen.routeName:
        return MaterialPageRoute(builder: (_) => const DeliveriesListScreen());
      case DeliveryDetailScreen.routeName:
        final id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DeliveryDetailScreen(deliveryId: id),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
