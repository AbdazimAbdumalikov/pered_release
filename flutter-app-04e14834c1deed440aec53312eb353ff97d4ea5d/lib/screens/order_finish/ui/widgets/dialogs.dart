import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text('Идёт запрос на сервер'),
          ],
        ),
      );
    },
  );
}

void showPreviouslySentDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context); // Закрыть диалог после 3 секунд
      });
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 16.0),
            Text('Запрос ранее успешно отправлен'),
          ],
        ),
      );
    },
  );
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context); // Закрыть диалог после 4 секунд
      });
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 16.0),
            Text('Заказ подтверждён'),
          ],
        ),
      );
    },
  );
}

void showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context); // Закрыть диалог после 4 секунд
      });
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              CupertinoIcons.xmark_circle,
              color: Colors.red,
              size: 60,
            ),
            SizedBox(height: 16.0),
            Text('Ошибка при отправке запроса'),
          ],
        ),
      );
    },
  );
}
void _showPreviouslySentDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context); // Закрыть диалог после 3 секунд
      });
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 16.0),
            Text('Запрос ранее успешно отправлен'),
          ],
        ),
      );
    },
  );
}


