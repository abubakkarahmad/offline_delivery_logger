enum DeliveryStatus {
  initial,
  inProgress,
  completed;

  static DeliveryStatus fromString(String s) {
    switch (s) {
      case 'New':
        return DeliveryStatus.initial;
      case 'InProgress':
        return DeliveryStatus.inProgress;
      case 'Completed':
        return DeliveryStatus.completed;
    }
    return DeliveryStatus.initial;
  }

  String get asString => toString().split('.').last;
}
