import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doctor_book/base/base_remote_data.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/features/choose_doctor/data/models/doctor_model.dart';
import 'package:doctor_book/features/info_patient/data/models/patient_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../process_schedule/data/model/schedule_model.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc()
      : super(const ScheduleState(
            listSchedule: [],
            message: '',
            doctorSchedule: {},
            patientSchedule: {})) {
    on<GetScheduleEvent>(_onGetScheduleEvent);
    on<ProcessScheduleEvent>(_onProcessScheduleEvent);
    on<DeleteScheduleEvent>(_onDeleteScheduleEvent);
  }

  FutureOr<void> _onGetScheduleEvent(
      GetScheduleEvent event, Emitter<ScheduleState> emit) async {
    try {
      final listSchedule = await BaseRemoteData().getData(
          collectionName: 'schedule',
          fromFirestore: ScheduleModel.fromFirestore);
      if (listSchedule.isEmpty) {
        emit(state.copyWith(listSchedule: [], message: 'success'));
      }

      List<ScheduleModel> listResultPaitent = [];
      List<ScheduleModel> listResultDoctor = [];
      Map<String, PatientModel> patientSchedule =
          Map.from(state.patientSchedule);
      Map<String, Doctor> doctorSchedule = Map.from(state.doctorSchedule);
      final listPatient = await BaseRemoteData().getData(
          collectionName: 'patient', fromFirestore: PatientModel.fromFirestore);

      final listDoctor = await BaseRemoteData().getData(
          collectionName: 'doctors', fromFirestore: Doctor.fromFirestore);

      for (int i = 0; i < listSchedule.length; i++) {
        if (listSchedule[i].uidPatient == UserSingleton().email) {
          listResultPaitent.add(listSchedule[i]);
          for (int index = 0; index < listDoctor.length; index++) {
            if (listSchedule[i].uidDoctor == listDoctor[index].email) {
              doctorSchedule[listSchedule[i].uidDoctor] = listDoctor[index];
            }
          }
        }
        if (listSchedule[i].uidDoctor == UserSingleton().email) {
          listResultDoctor.add(listSchedule[i]);
          for (int index = 0; index < listPatient.length; index++) {
            if (listPatient[index].email == listSchedule[i].uidPatient) {
              patientSchedule[listSchedule[i].uidPatient] = listPatient[index];
            }
          }
        }
      }
      if (UserSingleton().email.contains('doctor')) {
        emit(state.copyWith(
            listSchedule: listResultDoctor,
            patientSchedule: patientSchedule,
            message: 'success'));
      } else {
        emit(state.copyWith(
            listSchedule: listResultPaitent,
            doctorSchedule: doctorSchedule,
            message: 'success'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'error'));
    }
  }

  FutureOr<void> _onProcessScheduleEvent(
      ProcessScheduleEvent event, Emitter<ScheduleState> emit) async {
    List<ScheduleModel> listSchedule = List.from(state.listSchedule);
    for (var schedule in listSchedule) {
      if (schedule.uidPatient == event.schedule.uidPatient &&
          schedule.timeSchedule == event.schedule.timeSchedule) {
        var updateSchedule = schedule.copyWith(status: event.status);
        schedule = updateSchedule;
      }
    }
    //emit(state.copyWith(listSchedule: listSchedule, message: 'update status'));

    await BaseRemoteData()
        .updateSchedule(event.schedule.uidSchedule ?? ' ', event.status);

    emit(state.copyWith(
        listSchedule: listSchedule, message: 'update status firebase'));
  }

  FutureOr<void> _onDeleteScheduleEvent(
      DeleteScheduleEvent event, Emitter<ScheduleState> emit) async {
    await BaseRemoteData().deleteSchedule(event.uidSchedule);
    emit(state.copyWith(message: 'delete schuedule success'));
    
  }
}
