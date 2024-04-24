import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/features/home/application/services/notification_services.dart';
import 'package:volun_tek/src/features/home/domain/model/notification_model.dart';

// State provider for storing notification data
final notificationProvider =
    StateProvider<List<NotificationModel>>((ref) => []);

// State provider for managing the notification services
final notificationServiceProvider =
    StateProvider<NotificationServices>((ref) => NotificationServices());

// Future provider for fetching notifications
final getNotification = FutureProvider<List<NotificationModel>>((ref) {
  final notification = ref.watch(notificationServiceProvider);

  // Calling the method to fetch notifications from the service
  return notification.getNotifications();
});
