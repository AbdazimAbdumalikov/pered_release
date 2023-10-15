import 'package:europharm_flutter/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  // Обработка фонового сообщения здесь, например, перенаправление на страницу уведомления
  print("Handling a background message: ${message.messageId}");
  // Вызов кода для перенаправления на страницу уведомления
  // Например, можно использовать navigatorKey для этого
  navigatorKey.currentState?.pushNamed(
    '/notification_firebase',
    arguments: message,
  );
}

void registerBackgroundHandler() {
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
}
