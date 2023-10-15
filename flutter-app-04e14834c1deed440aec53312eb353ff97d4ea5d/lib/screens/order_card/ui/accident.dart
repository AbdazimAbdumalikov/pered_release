import 'package:europharm_flutter/screens/order_card/bloc/order_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccidentReportPage extends StatelessWidget {
  late final BuildContext context;
  final TextEditingController accidentMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<OrderDetailBloc>(), // Получите экземпляр OrderDetailBloc из вышестоящего провайдера
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Text('Сообщение о ДТП'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      color: Colors.red,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          child: Icon(Icons.warning_amber, color: Colors.white, size: 27,),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: accidentMessageController,
                            maxLines: 7,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Опишите подробности ДТП',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              contentPadding: EdgeInsets.all(12.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final accidentMessage = accidentMessageController.text;
                      if (accidentMessage.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Введите сообщение о ДТП'),
                          ),
                        );
                      } else {
                        context.read<OrderDetailBloc>().add(
                          OrderDetailEventAccident(
                              message: accidentMessage),
                        );
                        Navigator.of(context).pop(); // Закройте диалоговое окно
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Цвет кнопки
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Сообщить о ДТП',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Что делать водителю при ДТП?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Обеспечьте безопасность: убедитесь, что аварийное место безопасно для вас и других участников движения.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Позвоните в службу экстренной помощи (при необходимости).',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Обменяйтесь данными с другими водителями: ФИО, номерами телефонов, номерами автомобилей.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Фотографируйте место ДТП и повреждения автомобилей.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Составьте и подпишите протокол ДТП, если это требуется.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
