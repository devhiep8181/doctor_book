part of 'process_schedule_bloc.dart';

sealed class ProcessScheduleEvent extends Equatable {
  const ProcessScheduleEvent();

  @override
  List<Object> get props => [];
}

class ChooseTimeEvent extends ProcessScheduleEvent {
  final String chooseTime;
  const ChooseTimeEvent({
    required this.chooseTime,
  });
  @override
  List<Object> get props => [chooseTime];
}

class ChooseDateEvent extends ProcessScheduleEvent {
  final String chooseDate;
  const ChooseDateEvent({
    required this.chooseDate,
  });

  @override
  List<Object> get props => [chooseDate];
}

class ScheduleEvent extends ProcessScheduleEvent {
  final String chooseDate;
  final String chooseTime;
  final String uidUser;
  final String uidDoctor;
  const ScheduleEvent({
    required this.chooseDate,
    required this.chooseTime,
    required this.uidUser,
    required this.uidDoctor,
  });

  @override
  List<Object> get props => [chooseDate, chooseTime, uidUser, uidDoctor];
}
