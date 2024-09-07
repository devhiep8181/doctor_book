import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctor_book/base/base_remote_data.dart';
import 'package:doctor_book/features/choose_doctor/data/models/doctor_model.dart';
import 'package:equatable/equatable.dart';

part 'get_doctor_event.dart';
part 'get_doctor_state.dart';

class GetDoctorBloc extends Bloc<GetDoctorEvent, GetDoctorState> {
  GetDoctorBloc() : super(GetDoctorInitial()) {
    on<GetDoctorToFirebase>(_onGetDoctorToFirebase);
  }

  FutureOr<void> _onGetDoctorToFirebase(
      GetDoctorToFirebase event, Emitter<GetDoctorState> emit) async {
    final listDoctor = await BaseRemoteData()
        .getData(collectionName: 'doctors', fromFirestore: Doctor.fromFirestore);
    log('list doctor: ${listDoctor.length}');
    listDoctor.forEach((e) {
      log('ELEMENT ============> $e');
    });

    emit(GetDoctorSuccess(listDoctor: listDoctor));
  }
}
