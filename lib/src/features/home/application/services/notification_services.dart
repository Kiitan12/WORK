// Import packages and files
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore library for database operations
import 'package:volun_tek/src/features/home/domain/model/notification_model.dart'; // NotificationModel class for representing notifications

// Service class for handling notifications
class NotificationServices {
  final firestore =
      FirebaseFirestore.instance; // Firestore instance for database access

  // Method to retrieve all notifications from Firestore
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final snapshot = await firestore
          .collection('notifications')
          .get(); // Retrieve collection snapshot from Firestore

      // Map snapshot documents to NotificationModel objects and convert to list
      final notifications = snapshot.docs
          .map((doc) => NotificationModel.fromJson(doc.data()))
          .toList();
      return notifications; // Return list of notifications
    } catch (e) {
      throw Exception(e); // Throw exception if an error occurs
    }
  }
}
