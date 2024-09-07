import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_book/base/base_remote_data.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/features/info_patient/data/models/patient_model.dart';
import 'package:doctor_book/features/process_schedule/data/model/schedule_model.dart';
import 'package:equatable/equatable.dart';

part 'process_schedule_event.dart';
part 'process_schedule_state.dart';

class ProcessScheduleBloc
    extends Bloc<ProcessScheduleEvent, ProcessScheduleState> {
  ProcessScheduleBloc()
      : super(const ProcessScheduleState(
            '',
            '',
            ProcessScheduleStatus.initial,
            PatientModel(
                uid: '',
                fullName: '',
                phoneNumber: '',
                birthDay: '',
                gender: ''),
            '')) {
    on<ChooseTimeEvent>(_onChooseTimeEvent);
    on<ChooseDateEvent>(_onChooseDateEvent);
    on<ScheduleEvent>(_onScheduleEvent);
  }

  FutureOr<void> _onChooseTimeEvent(
      ChooseTimeEvent event, Emitter<ProcessScheduleState> emit) {
    emit(state.copyWith(timeChoose: event.chooseTime));
  }

  FutureOr<void> _onChooseDateEvent(
      ChooseDateEvent event, Emitter<ProcessScheduleState> emit) {
    emit(state.copyWith(dayChoose: event.chooseDate));
    emit(state.copyWith(message: 'okok'));
  }

  FutureOr<void> _onScheduleEvent(
      ScheduleEvent event, Emitter<ProcessScheduleState> emit) async {
    await BaseRemoteData().schedule(ScheduleModel(
        daySchedule: state.dayChoose,
        timeSchedule: state.timeChoose,
        status: 2,
        uidPatient: UserSingleton().email,
        uidDoctor: event.uidDoctor,
        ));
    emit(state.copyWith(message: 'success schedule'));
    emit(state.copyWith(message: ''));
  }
}
