import '../repositories/sync_queue_repository.dart';

class ReplayOutbox {
  final SyncQueueRepository repo;
  ReplayOutbox(this.repo);
  Future<int> call() => repo.replayOutbox();
}
