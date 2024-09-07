import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctor_book/base/base_remote_data.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/features/info_patient/data/models/patient_model.dart';
import 'package:equatable/equatable.dart';

part 'info_patient_event.dart';
part 'info_patient_state.dart';

class InfoPatientBloc extends Bloc<InfoPatientEvent, InfoPatientState> {
  InfoPatientBloc()
      : super(const InfoPatientState(
            InfoPatientStatus.init,
            PatientModel(
                uid: '',
                fullName: '',
                phoneNumber: '',
                birthDay: '',
                gender: ''),
            '')) {
    on<GetInfoPatientEvent>(_onGetInfoPatient);
    on<SaveInfoPatientEvent>(_onSaveInfoPatient);
    on<EditInfoPatientEvent>(_onEditInfoPatientEvent);
  }

  FutureOr<void> _onGetInfoPatient(
      GetInfoPatientEvent event, Emitter<InfoPatientState> emit) async {
    final listPatient = await BaseRemoteData().getData(
        collectionName: 'patient', fromFirestore: PatientModel.fromFirestore);
    PatientModel? patient;
    for (int i = 0; i < listPatient.length; i++) {
      if (listPatient[i].email == UserSingleton().email) {
        patient = listPatient[i];
      }
    }
    log('list doctor: ${listPatient.length}');
    listPatient.forEach((e) {
      log('ELEMENT ============> $e');
    });

    if (patient != null) {
      emit(state.copyWith(
          infoPatientStatus: InfoPatientStatus.success, patientModel: patient));
      //emit(state.copyWith(infoPatientStatus: InfoPatientStatus.loading));
    } else {
      emit(state.copyWith(infoPatientStatus: InfoPatientStatus.error));
      emit(state.copyWith(infoPatientStatus: InfoPatientStatus.loading));
    }
  }

  FutureOr<void> _onSaveInfoPatient(
      SaveInfoPatientEvent event, Emitter<InfoPatientState> emit) async {
    await BaseRemoteData().savePatient(event.patientModel);
    emit(state.copyWith(infoPatientStatus: InfoPatientStatus.success));
    emit(state.copyWith(infoPatientStatus: InfoPatientStatus.loading));
  }

  FutureOr<void> _onEditInfoPatientEvent(
      EditInfoPatientEvent event, Emitter<InfoPatientState> emit) {
    emit(state.copyWith(message: 'edit'));
    emit(state.copyWith(message: ' '));
  }
}
