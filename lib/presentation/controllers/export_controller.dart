import 'package:flutter/foundation.dart';
import 'package:offline_delivery_logger/data/service/pdf_service.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/repositories/delivery_repository.dart';

class ExportController extends ChangeNotifier {
  final DeliveryRepository deliveryRepo;
  final PdfService _pdfService = PdfService();

  ExportController({required this.deliveryRepo});

  Future<String> generatePdf() async {
    final completed = await deliveryRepo.getCompleted();
    final path = await _pdfService.generateCompletedReport(
      completed.map((e) => e).map((e) => throw UnimplementedError()).toList(),
    );
    return path;
  }

  Future<void> sharePdf() async {
    final path = await generatePdf();
    await Share.shareXFiles([XFile(path)], text: 'Completed Deliveries Report');
  }
}
