import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../base/base_remote_data.dart';
import '../../../../choose_doctor/data/models/doctor_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(const SearchState(
            message: '', listDoctor: [], listDoctorSearch: [])) {
    on<SearchInit>(_onSearchInit);
    on<SearchDoctor>(_onSearchDoctor);
    on<SearchDepartment>(_onSearchDepartment);
  }

  FutureOr<void> _onSearchInit(
      SearchInit event, Emitter<SearchState> emit) async {
    final listDoctor = await BaseRemoteData().getData(
        collectionName: 'doctors', fromFirestore: Doctor.fromFirestore);
    log('list doctor: ${listDoctor.length}');
    listDoctor.forEach((e) {
      log('ELEMENT ============> $e');
    });

    emit(state.copyWith(listDoctor: listDoctor));
  }

  FutureOr<void> _onSearchDoctor(
      SearchDoctor event, Emitter<SearchState> emit) {
    List<Doctor> listSearchDoctor = [];

    for (int i = 0; i < state.listDoctor.length; i++) {
      if (state.listDoctor[i].fullName.contains(event.textSearch)) {
        listSearchDoctor.add(state.listDoctor[i]);
      }
    }
    emit(state.copyWith(
        listDoctorSearch: listSearchDoctor, message: 'search suceess'));
  }

  FutureOr<void> _onSearchDepartment(
      SearchDepartment event, Emitter<SearchState> emit) async {
    List<Doctor> listSearchDoctor = [];

    for (int i = 0; i < state.listDoctor.length; i++) {
      if (state.listDoctor[i].department == event.textSeatch) {
        listSearchDoctor.add(state.listDoctor[i]);
      }
    }
    emit(state.copyWith(
        listDoctorSearch: listSearchDoctor, message: 'search suceess'));
   // emit(state.copyWith(message: ' '));
  }
}
