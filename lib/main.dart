import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
import 'globals.dart';
import 'src/routing/router.dart';
import 'src/routing/routes.dart';

// Function to handle background messages received by Firebase Messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  // Get the notification title and body from the message
  String title = message.notification?.title ?? 'Notification';
  String body = message.notification?.body ?? 'Notification body';

  // create a collection in firestore to store the notification
  // add the notification to the collection
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set up background message handler for Firebase Messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // // Initialize Firebase Messaging instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Obtain APNS (apple push notifiication services) token on iOS devices

  if (Platform.isIOS) {
    final apnsToken = await messaging.getAPNSToken();
    if (apnsToken != null) {
      // APNS token is available, make FCM (firebase cloud messaging) plugin API requests...
      print("Firebase messaging token: ${await messaging.getToken()}");
    }
  } else {
    // Obtain FCM token on non-iOS devices
    print("Firebase messaging token: ${await messaging.getToken()}");
  }

  // Request permission for receiving notifications
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User granted permission");
  } else {
    print("User declined or has not accepted permission");
    // retry request permission
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
  }
  // code to run the application
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = RouteGenerator();

  @override
  Widget build(BuildContext context) {
    // return the Material app widget
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'VolunTek',
      initialRoute: splashRoot,
      onGenerateRoute: router.routeGenerate,
      scaffoldMessengerKey: snackBarKey,
      navigatorKey: navigatorKey,
    );
  }
}
