import 'dart:io';
import 'package:intl/intl.dart';
import 'package:offline_delivery_logger/model/delivery_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<String> generateCompletedReport(List<DeliveryModel> deliveries) async {
    final doc = pw.Document();
    final now = DateFormat(
      "yyyy-MM-dd HH:mm:ss 'UTC'",
    ).format(DateTime.now().toUtc());

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Completed Deliveries Report',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text('Generated: $now'),
          pw.SizedBox(height: 12),
          pw.Table.fromTextArray(
            headers: [
              'ID',
              'Customer',
              'Start Time',
              'Start (lat,lng)',
              'End Time',
              'End (lat,lng)',
              'Duration',
            ],
            data: deliveries.map((d) {
              final events = d.events;
              final start = events.firstWhere((e) => e.status == 'InProgress');
              final end = events.lastWhere((e) => e.status == 'Completed');
              final startTime = start.at;
              final endTime = end.at;
              Duration? dur;
              dur = DateTime.parse(
                endTime,
              ).difference(DateTime.parse(startTime));
              return [
                d.id,
                d.customer,
                startTime,
                '${start.lat.toStringAsFixed(3)}, ${start.lng.toStringAsFixed(3)}',
                endTime,
                '${end.lat.toStringAsFixed(3)}, ${end.lng.toStringAsFixed(3)}',
                _formatDuration(dur),
              ];
            }).toList(),
            cellAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            cellPadding: const pw.EdgeInsets.all(6),
          ),
        ],
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/completed_deliveries_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await doc.save());
    return file.path;
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return '${h}h ${m}m ${s}s';
  }
}
