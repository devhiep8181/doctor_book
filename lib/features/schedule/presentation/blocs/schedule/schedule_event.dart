part of 'schedule_bloc.dart';

class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetScheduleEvent extends ScheduleEvent {}

class ProcessScheduleEvent extends ScheduleEvent {
  final int status;
  final ScheduleModel schedule;
  const ProcessScheduleEvent({
    required this.status,
    required this.schedule,
  });

  @override
  List<Object> get props => [status, schedule];
}

class DeleteScheduleEvent extends ScheduleEvent {
  final String uidSchedule;
  const DeleteScheduleEvent({
    required this.uidSchedule,
  });
}
