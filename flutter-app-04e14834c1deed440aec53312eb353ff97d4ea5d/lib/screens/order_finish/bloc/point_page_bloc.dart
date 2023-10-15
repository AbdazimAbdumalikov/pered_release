import 'dart:async';
import 'dart:developer';

import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/point_dto.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
part 'point_page_event.dart';

part 'point_page_state.dart';

part 'parts/_finish.dart';

class PointPageBloc extends Bloc<PointPageEvent, PointPageState> {
  PointPageBloc({
    required this.repository,
  }) : super(PointPageStateLoading()) {
    on<PointPageEventLoadProducts>(_read);
    on<PointPageEventProductFinish>(_finish);
    on<PointPageEventFinishingPoint>(_finishingPoint);
    on<PointPageEventScanBarcode>(_scanBarcode);
    on<PointPageEventContainerAccept>(_containerAccept);
  }

  final GlobalRepository repository;
  int? pointId;
  PointDTO? currentPoint;
  ///
  ///
  ///
  Future<void> _read(
      PointPageEventLoadProducts event,
      Emitter<PointPageState> emit,
      ) async {
    try {
      bool areAllFinished = true;

      final result = await repository.orderPointProducts(event.pointId);
      log(result.toString());

      // pointId = event.pointId;
      pointId = event.pointId;
      currentPoint = result;
      log("IS SCANNED::::::${currentPoint?.containers?.first.isScanned}");
      for (var element in currentPoint!.containers!) {
        if (!element.isScanned) {
          areAllFinished = false;
        }
      }
      emit(
        PointPageStateLoaded(
          orderPoint: currentPoint ?? result,
          areAllFinished: areAllFinished,
        ),
      );
    } catch (e) {
      // log('znc.wnckadajkc');
      emit(
        PointPageStateError(
          error: AppError(
            message: e.dioErrorMessage,
            code: e.dioErrorStatusCode,
          ),
        ),
      );
    }
  }

  Future<void> _finishingPoint(
      PointPageEventFinishingPoint event,
      Emitter<PointPageState> emit,
      ) async {
    emit(PointPageStateLoading());

    try {
      log('Ошибка');
      await repository.orderPointFinish(pointId: event.pointId);
      await repository.sendContainers(currentPoint?.containers ?? []);
      emit(PointPageStateFinished());
    } catch (e) {
      emit(
        PointPageStateError(
          error: AppError(
            message: e.dioErrorMessage,
            code: e.dioErrorStatusCode,
          ),
        ),
      );
    }
  }


  Future<void> _scanBarcode(
      PointPageEventScanBarcode event,
      Emitter<PointPageState> emit,
      ) async {
    emit(PointPageStateLoading());

    bool areAllFinished = false;
    bool flag = false;
    for (ContainerDTO e in currentPoint?.containers ?? []) {
      if (e.code == event.code) {
        flag = true;
        e.isScanned = true;
        await repository.acceptContainerOrderScan(event.code);
        break;
      }
    }
    for (var element in currentPoint!.containers!) {
      log('${element.isScanned}');
      if (!element.isScanned) {
        areAllFinished = false;
        break; // Если хотя бы один контейнер не отсканирован, прерываем цикл
      }
    }

    if (flag) {
      if (areAllFinished) {
        // Выполнить логику, когда все контейнеры уже отсканированы
        // Например, отправить FinishedState
        emit(PointPageStateFinished());
      } else {
        // Выполнить логику, когда не все контейнеры отсканированы
        emit(PointPageStateLoaded(
            orderPoint: currentPoint!, areAllFinished: areAllFinished));
      }
    } else {
      emit(PointPageStateError(
          error: const AppError(
              message: 'В списке нет товар с таким штрихкодом!')));
    }
  }


  Future<void> _containerAccept(
      PointPageEventContainerAccept event,
      Emitter<PointPageState> emit,
      ) async {
    bool areAllFinished = true;
    try {
      final response = await repository.acceptContainerOrder(
        event.containerId,
        event.code,
      );

      if (response.success == true) {
        // Вызываем метод updateContainerState для обновления состояния контейнера
        updateContainerState(event.containerId, event.code, isScanned: true);

        // Проверяем, все ли контейнеры уже отсканированы
        for (var element in currentPoint!.containers!) {
          if (!element.isScanned) {
            areAllFinished = false;
            break; // Если хотя бы один контейнер не отсканирован, прерываем цикл
          }
        }

        if (areAllFinished) {
          // Выполнить логику, когда все контейнеры уже отсканированы
          // Например, отправить FinishedState
          emit(PointPageStateFinished());
        } else {
          // Выполнить логику, когда не все контейнеры отсканированы
          emit(PointPageStateContainerAccepted(message: 'Запрос успешно отправлен', areAllFinished: true));
        }
      } else {
        emit(PointPageStateError(error: const AppError(message: 'Ошибка при отправке запроса..............')));
      }
    } catch (e) {
      emit(PointPageStateError(error: const AppError(message: 'Ошибка при отправке запроса')));
    }
  }

  Future<void> updateContainerState(int containerId, String code, {required bool isScanned}) async {
    if (currentPoint != null) {
      currentPoint = currentPoint!.copyWith(
        containers: currentPoint!.containers?.map((container) {
          return (container.containerId == containerId && container.code == code)
              ? container.copyWith(isScanned: true)
              : container;
        }).toList(),
      );
    }
  }
  bool areAllContainersScanned() {
    if (currentPoint != null) {
      return currentPoint!.containers?.every((container) => container.isScanned) ?? false;
    }
    return false;
  }
}
//
//
//
// import 'package:europharm_flutter/network/dio_wrapper/dio_extension.dart';
// import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
// import 'package:europharm_flutter/network/models/point_dto.dart';
// import 'package:europharm_flutter/network/repository/global_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// part 'point_page_event.dart';
// part 'point_page_state.dart';
// part 'parts/_finish.dart';
//
// class PointPageBloc extends Bloc<PointPageEvent, PointPageState> {
//   final GlobalRepository repository;
//   int? pointId;
//   PointDTO? currentPoint;
//   List<int> completedContainerIds = [];
//
//   PointPageBloc({
//     required this.repository,
//   }) : super(PointPageStateLoading()) {
//     on<PointPageEventLoadProducts>(_read);
//     on<PointPageEventProductFinish>(_finish);
//     on<PointPageEventFinishingPoint>(_finishingPoint);
//     on<PointPageEventScanBarcode>(_scanBarcode);
//     on<PointPageEventContainerAccept>(_containerAccept);
//   }
//
//   Future<void> _read(PointPageEventLoadProducts event, Emitter<PointPageState> emit) async {
//     try {
//       currentPoint = await repository.orderPointProducts(event.pointId);
//       pointId = event.pointId;
//
//       final areAllFinished = currentPoint?.containers?.every((container) => container.isScanned) ?? false;
//       emit(PointPageStateLoaded(
//         orderPoint: currentPoint!,
//         areAllFinished: areAllFinished,
//       ));
//
//       completedContainerIds = currentPoint?.containers
//           ?.where((container) => container.isScanned)
//           .map((container) => container.containerId!)
//           .toList() ?? [];
//       await _saveCompletedContainerIds(completedContainerIds);
//     } catch (e) {
//       emit(PointPageStateError(
//         error: AppError(
//           message: e.dioErrorMessage,
//           code: e.dioErrorStatusCode,
//         ),
//       ));
//     }
//   }
//
//   Future<void> _finishingPoint(PointPageEventFinishingPoint event, Emitter<PointPageState> emit) async {
//     emit(PointPageStateLoading());
//     try {
//       await repository.orderPointFinish(pointId: event.pointId);
//       await repository.sendContainers(currentPoint?.containers ?? []);
//       emit(PointPageStateFinished());
//     } catch (e) {
//       emit(PointPageStateError(
//         error: AppError(
//           message: e.dioErrorMessage,
//           code: e.dioErrorStatusCode,
//         ),
//       ));
//     }
//   }
//
//   Future<void> _scanBarcode(PointPageEventScanBarcode event, Emitter<PointPageState> emit) async {
//     emit(PointPageStateLoading());
//
//     if (!_processContainerScan(event.code)) {
//       emit(PointPageStateError(
//         error: const AppError(
//           message: 'В списке нет товара с таким штрихкодом!',
//         ),
//       ));
//       return;
//     }
//
//     final areAllFinished = currentPoint?.containers?.every((container) => container.isScanned) ?? false;
//     if (areAllFinished) {
//       emit(PointPageStateFinished());
//       await _sendScannedContainer(event.code);
//     } else {
//       emit(PointPageStateLoaded(orderPoint: currentPoint!, areAllFinished: areAllFinished));
//     }
//   }
//
//   bool _processContainerScan(String code) {
//     final containerToUpdate = currentPoint?.containers?.firstWhere(
//           (container) => container.code == code,
//       orElse: () => ContainerDTO(),
//     );
//
//     if (containerToUpdate != null) {
//       if (containerToUpdate.containerId != null) {
//         int containerId = containerToUpdate.containerId!;
//         containerToUpdate.isScanned = true;
//         repository.acceptContainerOrderScan(code);
//         _updateContainerState(containerId, code, isScanned: true);
//         emit(PointPageStateLoaded(orderPoint: currentPoint!, areAllFinished: areAllFinished));
//         return true;
//       }
//     }
//
//     return false;
//   }
//
//   Future<void> _sendScannedContainer(String code) async {
//     try {
//       final response = await repository.acceptContainerOrderScan(code);
//
//       if (response.success == true) {
//         emit(PointPageStateContainerAccepted(
//           message: 'Запрос успешно отправлен',
//           areAllFinished: true,
//         ));
//       } else {
//         emit(PointPageStateError(
//           error: const AppError(message: 'Ошибка при отправке запроса на сервер'),
//         ));
//       }
//     } catch (e) {
//       emit(PointPageStateError(
//         error: const AppError(message: 'Ошибка при отправке запроса на сервер'),
//       ));
//     }
//   }
//
//   Future<void> _containerAccept(PointPageEventContainerAccept event, Emitter<PointPageState> emit) async {
//     try {
//       final response = await repository.acceptContainerOrder(event.containerId, event.code);
//
//       if (response.success == true) {
//         _updateContainerState(event.containerId, event.code, isScanned: true);
//         final areAllFinished = currentPoint?.containers?.every((container) => container.isScanned) ?? false;
//         emit(PointPageStateContainerAccepted(
//           message: 'Запрос успешно отправлен',
//           areAllFinished: areAllFinished,
//         ));
//       } else {
//         emit(PointPageStateError(error: const AppError(message: 'Ошибка при отправке запроса на сервер')));
//       }
//     } catch (e) {
//       emit(PointPageStateError(error: const AppError(message: 'Ошибка при отправке запроса на сервер')));
//     }
//   }
//
//   void _updateContainerState(int containerId, String code, {required bool isScanned}) {
//     final containerToUpdate = currentPoint?.containers?.firstWhere(
//           (container) => container.containerId == containerId,
//       orElse: () => ContainerDTO(),
//     );
//
//     if (containerToUpdate != null) {
//       containerToUpdate.isScanned = isScanned;
//       _updateContainerState(containerId, code, isScanned: isScanned);
//     }
//   }
//
//   Future<void> _saveCompletedContainerIds(List<int> completedIds) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('completedContainerIds', completedIds.map((id) => id.toString()).toList());
//   }
//
//   void updateContainerState(int containerId, String code, {required bool isScanned}) {
//     if (state is PointPageStateLoaded) {
//       final loadedState = state as PointPageStateLoaded;
//       final updatedContainers = loadedState.orderPoint.containers?.map((container) {
//         if (container.containerId == containerId) {
//           return container.copyWith(isScanned: isScanned);
//         }
//         return container;
//       }).toList();
//
//       final updatedOrderPoint = loadedState.orderPoint.copyWith(containers: updatedContainers);
//       final updatedState = PointPageStateLoaded(
//         orderPoint: updatedOrderPoint,
//         areAllFinished: loadedState.areAllFinished,
//       );
//
//       emit(updatedState);
//     }
//   }
// }