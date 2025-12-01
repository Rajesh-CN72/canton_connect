import 'dart:async';

class MockNotificationService {
  final StreamController<int> _notificationCountController = StreamController<int>.broadcast();
  
  Stream<int> get notificationCount => _notificationCountController.stream;
  
  void updateNotificationCount(int count) {
    _notificationCountController.add(count);
  }
  
  void dispose() {
    _notificationCountController.close();
  }
}
