import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as dev;

class NotificationApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    dev.log('Token: $fcmToken');
  }
}
