part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  const ScheduleState({
    required this.listSchedule,
    required this.message,
    required this.doctorSchedule,
    required this.patientSchedule,
  });
  final List<ScheduleModel> listSchedule;
  final String message;
  final Map<String, Doctor> doctorSchedule;
  final Map<String, PatientModel> patientSchedule;

  @override
  List<Object> get props =>
      [listSchedule, message, doctorSchedule, patientSchedule];

  ScheduleState copyWith({
    List<ScheduleModel>? listSchedule,
    String? message,
    Map<String, Doctor>? doctorSchedule,
    Map<String, PatientModel>? patientSchedule,
  }) {
    return ScheduleState(
      listSchedule: listSchedule ?? this.listSchedule,
      message: message ?? this.message,
      doctorSchedule: doctorSchedule ?? this.doctorSchedule,
      patientSchedule: patientSchedule ?? this.patientSchedule,
    );
  }
}
