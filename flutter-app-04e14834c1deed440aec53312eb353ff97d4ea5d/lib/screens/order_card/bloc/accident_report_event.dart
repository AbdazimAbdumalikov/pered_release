part of 'accident_report_bloc.dart';

abstract class AccidentReportEvent {}

class ReportAccident extends AccidentReportEvent {
  final String message;

  ReportAccident({required this.message});
}
