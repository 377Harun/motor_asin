import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseNotificationService {
  late final FirebaseMessaging messaging;

  void settingNotification() async {
    await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  void connectNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    settingNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      Get.snackbar(
          "${event.notification?.title}", "${event.notification?.body}",
          icon: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Image.network("${event.notification?.android?.imageUrl}"),
          ),
          colorText: Colors.white,
          backgroundColor: Colors.blueGrey);
    });
    messaging
        .getToken()
        .then((value) => print("token : $value name FCM Token"));
  }

  static Future backGroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
    return message;
  }
}
