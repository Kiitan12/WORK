// Import Firestore library
import 'package:cloud_firestore/cloud_firestore.dart';

// Model class representing a notification
class NotificationModel {
  String title; // Title of the notification
  String body; // Body content of the notification
  Timestamp date; // Timestamp indicating the date and time of the notification

  // Constructor for creating a NotificationModel instance
  NotificationModel({
    required this.title, // Required title parameter
    required this.body, // Required body parameter
    required this.date, // Required date parameter
  });

  // Factory method to create a NotificationModel instance from JSON data
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"] ??
            "", // Initialize title from JSON data, defaulting to an empty string if null
        body: json["body"] ??
            "", // Initialize body from JSON data, defaulting to an empty string if null
        date: json["date"] ??
            Timestamp
                .now(), // Initialize date from JSON data, defaulting to the current timestamp if null
      );

  // Method to convert the NotificationModel instance to JSON format
  Map<String, dynamic> toJson() => {
        "title": title, // Convert title to JSON
        "body": body, // Convert body to JSON
        "date": date, // Convert date to JSON
      };
}
