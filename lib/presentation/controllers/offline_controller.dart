import 'package:flutter/material.dart';
import 'package:offline_delivery_logger/data/service/offline_service.dart';
import 'package:offline_delivery_logger/domain/repositories/delivery_repository.dart';
import 'package:offline_delivery_logger/domain/repositories/sync_queue_repository.dart';

class OfflineController extends ChangeNotifier {
  final OfflineService offlineService;
  final SyncQueueRepository syncRepo;
  final DeliveryRepository deliveryRepo;

  bool _isOffline = false;
  int _queued = 0;
  bool get isOffline => _isOffline;
  int get queued => _queued;

  OfflineController({
    required this.offlineService,
    required this.syncRepo,
    required this.deliveryRepo,
  }) {
    _isOffline = offlineService.isOffline.value;
    _refreshQueued();
    offlineService.isOffline.addListener(() {
      _isOffline = offlineService.isOffline.value;
      notifyListeners();
    });
  }

  Future<void> toggle(BuildContext context) async {
    final newState = !_isOffline;
    offlineService.setOffline(newState);
    _isOffline = newState;
    notifyListeners();

    if (!newState) {
      // Went online: replay
      final countBefore = await syncRepo.count();
      if (countBefore > 0 && context.mounted) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          const SnackBar(content: Text('Syncing queued operations...')),
        );
      }
      final synced = await syncRepo.replayOutbox();
      await _refreshQueued();
      if (synced > 0 && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Synced $synced operations')));
      }
    } else {
      await _refreshQueued();
    }
  }

  Future<void> _refreshQueued() async {
    _queued = await syncRepo.count();
    notifyListeners();
  }
}
