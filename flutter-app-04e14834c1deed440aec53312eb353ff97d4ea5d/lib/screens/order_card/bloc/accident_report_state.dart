part of 'accident_report_bloc.dart';

abstract class AccidentReportState {}

class AccidentReportInitial extends AccidentReportState {}

class AccidentReportLoading extends AccidentReportState {}

class AccidentReportSuccess extends AccidentReportState {}

class AccidentReportFailure extends AccidentReportState {
  final AppError error;

  AccidentReportFailure({required this.error});
}
