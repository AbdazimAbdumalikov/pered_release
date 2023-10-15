import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationFirebase extends StatelessWidget {
  const NotificationFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    // Проверяем, что message не равно null
    if (message != null) {
      final notification = message.notification;
      final data = message.data;

      print('Notification Title: ${notification?.title}');
      print('Notification Body: ${notification?.body}');
      print('Data: $data');

      return Scaffold(
        appBar: AppBar(
          title: Text('Уведомление'),
        ),
        body: Column(
          children: [
            Text(notification?.title ?? 'No title'),
            Text(notification?.body ?? 'No body'),
            Text(data.toString())
          ],
        ),
      );
    } else {
      // Обработка ситуации, когда message равно null
      return Scaffold(
        appBar: AppBar(
          title: Text('Уведомление'),
        ),
        body: Center(
          child: Text('No message data'),
        ),
      );
    }
  }
}
