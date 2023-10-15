import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/order_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'accident_report_event.dart';
part 'accident_report_state.dart';

class AccidentReportBloc extends Bloc<AccidentReportEvent, AccidentReportState> {
  AccidentReportBloc(this.repository) : super(AccidentReportInitial()) {
    on<AccidentReportEvent>(_sendAccidentReport);
  }

  final GlobalRepository repository;
  late OrderDTO currentOrder;
  int? orderId;

  @override
  Future<void> _sendAccidentReport(
      AccidentReportEvent event,
      Emitter<AccidentReportState> emit,
      ) async {
    emit(AccidentReportLoading());

    try {
      final currentPosition = await Geolocator.getCurrentPosition();
      final lat = currentPosition.latitude;
      final lng = currentPosition.longitude;

      // Замените OrderRepository на ваш репозиторий для работы с заказами
      final response = await repository.reportAccident(
        orderId: orderId!,
        message: (event as ReportAccident).message,
        lat: lat,
        lng: lng,
      );

      print('Данные отправлены на сервер:');
      print('Номер заказа: ${orderId}');
      print('Сообщение: ${event.message}');
      print('Координаты (lat, lng): ($lat, $lng)');
      print('Статус кода ответа: ${response.statusCode}');

      // Проверьте успешность отправки отчета
      if (response.statusCode == 200) {
        emit(AccidentReportSuccess()); // Отправьте соответствующее состояние при успехе
      } else {
        emit(
          AccidentReportFailure(
            error: AppError(message: "Ошибка при отправке отчета о ДТП"),
          ),
        ); // Отправьте состояние ошибки в случае неудачи
      }
    } catch (e) {
      emit(
        AccidentReportFailure(
          error: AppError(message: "Ошибка при отправке отчета о ДТП"),
        ),
      ); // Обработайте ошибку и отправьте соответствующее состояние
    }
  }
}
