import '../repositories/delivery_repository.dart';

class ExportCompletedReport {
  final DeliveryRepository repo;
  ExportCompletedReport(this.repo);

  Future<String> call() async {
    // Delegated to data layer via repo implementation
    // Returns path to generated PDF
    throw UnimplementedError();
  }
}
