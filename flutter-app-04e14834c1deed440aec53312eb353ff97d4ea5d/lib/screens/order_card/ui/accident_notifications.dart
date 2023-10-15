import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String message;
  final double latitude;
  final double longitude;
  final BuildContext context;
  final List<RequestData> requestDataList;

  SuccessPage({
    required this.message,
    required this.latitude,
    required this.longitude,
    required this.context,
    required this.requestDataList
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Успешная отправка отчета'),
        backgroundColor: Colors.green, // Цвет верхней панели
      ),
      body: ListView.builder(
        itemCount: requestDataList.length,
        itemBuilder: (context, index) {
          final requestData = requestDataList[index];
          return Card(
            elevation: 4.0, // Тень карточки
            margin: EdgeInsets.all(8.0), // Отступы
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle, // Иконка с галочкой
                    color: Colors.green, // Цвет иконки
                    size: 40.0, // Размер иконки
                  ),
                  SizedBox(height: 10.0), // Расстояние между элементами
                  Text(
                    'Отчет успешно отправлен!',
                    style: TextStyle(
                      fontSize: 18.0, // Размер шрифта
                      fontWeight: FontWeight.bold, // Жирный шрифт
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Сообщение: ${requestData.message}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    'Координаты (lat, lng): (${requestData.latitude}, ${requestData.longitude})',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RequestData {
  final String message;
  final double latitude;
  final double longitude;

  RequestData({
    required this.message,
    required this.latitude,
    required this.longitude,
  });
}

