import 'package:flutter/foundation.dart';

class OfflineService {
  final ValueNotifier<bool> isOffline = ValueNotifier<bool>(false);

  void setOffline(bool offline) {
    isOffline.value = offline;
  }
}
