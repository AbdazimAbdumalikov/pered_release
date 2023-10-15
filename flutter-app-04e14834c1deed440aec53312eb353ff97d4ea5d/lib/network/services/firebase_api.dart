import 'package:europharm_flutter/main.dart';
import 'package:europharm_flutter/screens/notifications_screen/ui/notification_firebase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotificatons() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    print('Token: $fCMToken');

    initPushNotificaton();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Перейдите на страницу NotificationFirebase и передайте сообщение в качестве аргумента
    navigatorKey.currentState?.pushNamed(
      '/notification_firebase',
      arguments: message,
    );
  }

  Future initPushNotificaton() async {
    // Обработайте пуш-уведомления, которые открыты приложением или открыты из уведомления
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Обработайте исходное уведомление, если приложение было закрыто в момент получения уведомления
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  }
}
