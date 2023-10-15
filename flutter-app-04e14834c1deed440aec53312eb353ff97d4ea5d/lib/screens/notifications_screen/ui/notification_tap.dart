import 'package:europharm_flutter/screens/notifications_screen/ui/notification_firebase.dart';
import 'package:europharm_flutter/screens/notifications_screen/ui/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationTap extends StatelessWidget {
  const NotificationTap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Text('Все'),
                Text('Другие'),
              ],
            ),
            title: Text('Уведомления'),
            centerTitle: true,
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/images/svg/arrow_back.svg",
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ),
          body: const TabBarView(
            children: [
              NotificationFirebase(),
              NotificationsPage(),
            ],
          ),
        ),
      ),
    );
  }
}