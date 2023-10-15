part of 'point_page_bloc.dart';

@immutable
abstract class PointPageState {}

class PointPageStateLoading extends PointPageState {}

class PointPageStateLoaded extends PointPageState {
  final PointDTO orderPoint;
  final bool areAllFinished;

  PointPageStateLoaded({
    required this.orderPoint,
    this.areAllFinished = false,
  });
}

class PointPageStateFinished extends PointPageState {}

class PointPageStateContainerAccepted extends PointPageState {
  final String message;

  PointPageStateContainerAccepted({
    required this.message,
    required bool areAllFinished,
  });
}

class PointPageStateError extends PointPageState {
  final AppError error;

  PointPageStateError({
    required this.error,
  });
}