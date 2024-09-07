part of 'process_schedule_bloc.dart';

enum ProcessScheduleStatus { initial, loading, success, error }

extension ProcessScheduleStatusX on ProcessScheduleStatus {
  bool get isSuccess => [ProcessScheduleStatus.success].contains(this);
}

class ProcessScheduleState extends Equatable {
  const ProcessScheduleState(this.timeChoose, this.dayChoose,
      this.processScheduleStatus, this.patient, this.message);

  final String timeChoose;
  final String dayChoose;
  final ProcessScheduleStatus processScheduleStatus;
  final PatientModel patient;
  final String message;

  @override
  List<Object> get props =>
      [timeChoose, dayChoose, processScheduleStatus, patient, message];

  ProcessScheduleState copyWith({
    String? timeChoose,
    String? dayChoose,
    ProcessScheduleStatus? processScheduleStatus,
    PatientModel? patient,
    String? message,
  }) {
    return ProcessScheduleState(
      timeChoose ?? this.timeChoose,
      dayChoose ?? this.dayChoose,
      processScheduleStatus ?? this.processScheduleStatus,
      patient ?? this.patient,
      message ?? this.message,
    );
  }
}
